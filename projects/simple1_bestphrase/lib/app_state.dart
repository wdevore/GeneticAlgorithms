import 'package:flutter/material.dart';

import 'population.dart';
import 'simulation.dart' as sim;
import 'text_list_model.dart';

class AppState extends ChangeNotifier {
  late sim.Simulation simulation;

  String target = ''; // phrase
  int popmax = 0;
  double mutationRate = 0;
  Population? population;

  bool stopped = true;

  TextListModel textListModel = TextListModel();

  AppState();

  factory AppState.create() {
    AppState appState = AppState();
    appState.simulation = sim.Simulation(appState);

    return appState;
  }

  void setup() {
    target = 'To be or not to be.';
    popmax = 200;
    mutationRate = 0.01;
    reset();
  }

  void reset() {
    // Create a population with a target phrase, mutation rate, and population max
    population = Population.create(target, mutationRate, popmax);
  }

  void start() {
    stopped = false;
  }

  void stop() {
    stopped = true;
  }

  void update() {
    notifyListeners();
  }
}
