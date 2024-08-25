import 'dart:isolate';
import 'package:flutter/material.dart';

import 'population.dart';
import '../ga_simulation.dart' as sim;

bool isExit = false;
const updateInterval = 100;
int intervalCnt = 0;

// This isolate is sent commands and data via the port.
IsolateState iso = IsolateState.create();

class IsolateState {
  late sim.GASimulation simulation;

  bool isPaused = true;
  Population? population;

  String target = ''; // phrase
  int popmax = 0;
  double mutationRate = 0;

  bool configured = false;
  bool finalUpdateSent = false;

  IsolateState();

  factory IsolateState.create() {
    IsolateState iso = IsolateState();

    iso.simulation = sim.GASimulation();

    return iso;
  }

  void configure(List<dynamic> parameters) {
    target = parameters[0];
    mutationRate = parameters[1];
    popmax = parameters[2];

    // Create a population with a target phrase, mutation rate, and population max
    population = Population.create(target, mutationRate, popmax);

    configured = true;
  }
}

gaIsolate(SendPort sendPort) async {
  debugPrint('SimIsolate: Entered isolate');
  // Bind ports
  ReceivePort port = ReceivePort();

  sendPort.send(port.sendPort);

  monitorPort(port, sendPort);
  debugPrint('SimIsolate: Monitoring Port traffic from Main Isolate');

  // The outer loop is for controlling isolate lifetime.
  // The inner loop is the simulation itself.
  for (; !isExit;) {
    if (iso.configured) {
      // debugPrint('SimIsolate: isolate configured');
      Population? pop = iso.population!;

      // The simulation can be paused, running or finished.
      while (!iso.isPaused && !pop.finished) {
        // debugPrint('SimIsolate: running sim');
        // Generate mating pool
        pop.naturalSelection();

        // Create next generation
        pop.generate();

        // Calculate fitness
        pop.calcFitness();

        pop.evaluate();

        intervalCnt++;

        if (intervalCnt > updateInterval) {
          intervalCnt = 0;
          await Future.delayed(const Duration(microseconds: 1), () {
            sendPort.send([
              'UpdStats',
              pop.generations,
              pop.averageFitness,
              pop.best,
            ]);
          });
          // sendUpdate(pop, sendPort);
        }
      }

      if (pop.finished) {
        // Automatically pause because sim completed.
        iso.isPaused = true;
        if (!iso.finalUpdateSent) {
          iso.finalUpdateSent = true;

          await Future.delayed(const Duration(microseconds: 1), () {
            sendPort.send([
              'UpdStats',
              pop.generations,
              pop.averageFitness,
              pop.best,
            ]);
          });

          await Future.delayed(const Duration(microseconds: 1), () {
            sendPort.send([
              'UpdPhrases',
              pop.phraseSubset,
            ]);
          });
        }
      }
    }

    await Future.delayed(const Duration(microseconds: 10));
  }

  debugPrint('SimIsolate: Exited isolate');
}

// This doesn't really need to be a Future.
void monitorPort(ReceivePort port, SendPort sendPort) {
  port.listen(
    (msg) {
      List<dynamic> data = msg;
      // debugPrint('SimIsolate: ${data[0]}');
      switch (msg[0]) {
        case 'Stop':
          iso.isPaused = true;
          break;
        case 'Run':
          iso.isPaused = false;
          break;
        case 'Conf':
          iso.finalUpdateSent = false;
          iso.configure(data.sublist(1, data.length));
          break;
        case 'Info':
          // sendPort.send(['Info', 'running=$isPaused']);
          break;
        case 'Exit':
          isExit = true;
          break;
      }
    },
  );
}
