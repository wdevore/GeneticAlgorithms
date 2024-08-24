import 'package:flutter/material.dart';

import 'app_state.dart';
import 'population.dart';

class Simulation {
  final AppState ast;

  Simulation(this.ast);

  void simulate() {
    Population pop = ast.population;

    do {
      // Generate mating pool
      pop.naturalSelection();
      //Create next generation
      pop.generate();
      // Calculate fitness
      pop.calcFitness();

      pop.evaluate();

      // int gen = pop.generations;
      // String best = pop.best;
      // double world = pop.worldrecord;
      // debugPrint(
      //     'Gen: ${pop.generations}, best: ${pop.best}, world: ${pop.worldrecord}');

      // update display
      ast.update();
      // Future.delayed(const Duration(milliseconds: 1));

      // If we found the target phrase, stop
      //  && !ast.stopped
    } while (!pop.finished);

    debugPrint('Simulation complete');
  }

  // void simulate() async {
  //   // Future.delayed(const Duration(milliseconds: 1));
  //   await Future.doWhile(
  //     () async {
  //       Population pop = ast.population;

  //       // Generate mating pool
  //       pop.naturalSelection();
  //       //Create next generation
  //       pop.generate();
  //       // Calculate fitness
  //       pop.calcFitness();

  //       pop.evaluate();

  //       // update display
  //       ast.update();

  //       // If we found the target phrase, stop
  //       if (pop.finished || ast.stopped) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     },
  //   );
  // }
}
