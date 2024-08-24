import 'package:flutter/material.dart';

import 'population.dart';

class AppState extends ChangeNotifier {
  String target = ''; // phrase
  int popmax = 0;
  double mutationRate = 0;
  late Population population;

  bool stopped = true;

  void setup() {
    target = 'To be or not to be.';
    popmax = 200;
    mutationRate = 0.01;

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
