import 'dart:isolate';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'population.dart';

bool isPaused = false;
bool isExit = false;
const generationInformInterval = 100;
int intervalCnt = 0;

gaIsolate(SendPort sendPort, AppState appState) async {
  debugPrint('Entered isolate');
  // Bind ports
  ReceivePort port = ReceivePort();

  sendPort.send(port.sendPort);

  monitorPort(port, sendPort);

  Population pop = appState.population!;

  // The outer loop is for controlling isolate lifetime.
  // The inner loop is the simulation itself.
  for (; !isExit;) {
    // The simulation can be paused, running or finished.
    while (!isPaused && !pop.finished) {
      // Generate mating pool
      pop.naturalSelection();

      // Create next generation
      pop.generate();

      // Calculate fitness
      pop.calcFitness();

      pop.evaluate();

      intervalCnt++;

      if (intervalCnt > generationInformInterval) {
        intervalCnt = 0;
        sendPort.send(
            ['Upd', '${pop.generations},${pop.averageFitness},${pop.best}']);
      }
    }
  }

  if (pop.finished) {
    isPaused = true;
  }

  debugPrint('Exited isolate');
}

// This doesn't really need to be a Future.
void monitorPort(ReceivePort port, SendPort sendPort) {
  port.listen((msg) {
    switch (msg) {
      case 'Stop':
        isPaused = true;
        break;
      case 'Run':
        isPaused = false;
        break;
      case 'Info':
        sendPort.send(['Info', 'running=$isPaused']);
        break;
      case 'Exit':
        isExit = true;
        break;
    }
  });
}
