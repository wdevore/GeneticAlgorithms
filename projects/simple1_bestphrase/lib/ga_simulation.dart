import 'dart:isolate';

import 'package:flutter/material.dart';

import 'model/text_list_model.dart';
import 'simulation/simulation_isolate.dart';

// Simulation (aka app state) is a proxy between Main isolate and sim isolate.
// The sim isolate contains everything relative to the algorithm.
// Minimal data is sent to the main isolate periodically.
// Only large data can be requested.

class GASimulation extends ChangeNotifier {
  late ReceivePort port;
  late Stream<dynamic> streamOfMesssages;
  late SendPort simSendPort;

  String best = '';
  String target = ''; // phrase
  int popmax = 0;
  double mutationRate = 0;
  int generations = 0;
  double averageFitness = 0.0;
  TextListModel textListModel = TextListModel();

  Future<int> initialize() async {
    target = 'To be or not to be.'; // The lazy dog jumped over the fence
    popmax = 200;
    mutationRate = 0.01;

    // This is the receive port that the emu isolate sends data to.
    ReceivePort port = ReceivePort();

    // The main ControlPort is a normal stream, transform it in a broadcast one
    // this way we can listen to it in more than one place.
    final Stream<dynamic> streamOfMesssages = port.asBroadcastStream();

    // Launch the sim isolate. The simulation will be stopped/paused by default.
    await Isolate.spawn(
      gaIsolate,
      port.sendPort,
      debugName: 'SimIsolate',
    );

    // Get send port of sim isolate. The first thing the sim isolate does
    // is send its "input" port (aka send port)
    simSendPort = await streamOfMesssages.first;

    monitorPort(streamOfMesssages);

    return Future.value(0);
  }

  void monitorPort(Stream<dynamic> stream) {
    stream.listen(
      (message) {
        // debugPrint('Main Isolate: $message');
        switch (message[0]) {
          case 'UpdStats':
            generations = message[1];
            averageFitness = message[2];
            best = message[3];
            notifyListeners();
            break;
          case 'UpdPhrases':
            textListModel.lines.clear();
            textListModel.addLines(message[1]);
            notifyListeners();
            break;
          case 'Info':
            break;
        }
      },
    );
  }

  void configure() {
    simSendPort.send(['Conf', target, mutationRate, popmax]);
  }

  void start() {
    simSendPort.send(['Run']);
  }

  void stop() {
    simSendPort.send(['Stop']);
  }

  void exit() {
    simSendPort.send(['Exit']);
  }
}
