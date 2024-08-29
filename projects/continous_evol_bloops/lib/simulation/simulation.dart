import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fast_noise/fast_noise.dart';

import 'bloop.dart';
import 'dna.dart';
import 'food.dart';
import 'vector_2d.dart';

class GASimulation extends ChangeNotifier {
  late Random rando;

  bool running = false;
  late List<Bloop> bloops = [];
  late Food food;

  static const double width = 1000.0;
  static const double height = 500.0;

  late List<List<double>> noise2D;
  double noiseFrequency = 0.025;
  int noiseOctaves = 5;

  GASimulation(int populationSize, this.rando) {
    noise2D = noise2(
      (width * height).toInt(),
      1,
      // width.toInt(),
      // height.toInt(),
      noiseType: NoiseType.perlin,
      frequency: noiseFrequency,
      octaves: noiseOctaves,
      cellularReturnType: CellularReturnType.distance,
    );

    configure(populationSize, rando);
  }

  void configure(int populationSize, Random rando) {
    bloops.clear();

    for (var i = 0; i < populationSize; i++) {
      Bloop bloop = Bloop.create(
        rando,
        noise2D,
        width,
        height,
        Vector2D(
          rando.nextDouble() * width,
          rando.nextDouble() * height,
        ),
        DNA.create(1234, rando),
      );
      bloops.add(bloop);
    }

    // Create the food
    food = Food.create(populationSize, width, height, rando);
  }

  void start() {
    running = true;
  }

  void stop() {
    running = false;
  }

  void spawn() {
    Bloop bloop = Bloop.create(
      rando,
      noise2D,
      width,
      height,
      Vector2D(
        randomRange(width / 4, width - width / 4),
        randomRange(height / 4, height - height / 4),
      ),
      DNA.create(1234, rando),
    );
    bloops.add(bloop);
  }

  /// number is between: '>= [from]' but '< [to]'
  double randomRange(double from, double to) {
    double ran = rando.nextDouble() * (to - from) + from;
    return ran;
  }

  void run() async {
    Future.doWhile(() async {
      food.update();

      List<Bloop> childrenBloops = [];

      for (var bloop in bloops) {
        bloop.update();
        bloop.eat(food);

        // If it's dead, remove it and create food
        if (bloop.isDead) {
          // bloops.removeAt(i); // Not good to modify while iterating.
          // Place food where bloop died.
          food.add(bloop.position);
        } else {
          // Here is where each living bloop has a chance to reproduce.
          // If it does, it is added to the population.
          // Note the value of "child" is undefined if it does not.
          Bloop? child = bloop.reproduce();
          if (child != null) {
            childrenBloops.add(child);
          }
        }
      }

      // Remove all dead bloops
      bloops.removeWhere((bloop) => bloop.isDead);

      // Add newly born bloops to population
      bloops.addAll(childrenBloops);

      // Triggers Custom painter to paint.
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 16));
      return running;
    });
  }
}
