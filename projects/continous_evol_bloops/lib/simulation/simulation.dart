import 'package:flutter/material.dart';
import 'package:fast_noise/fast_noise.dart';

import 'bloop.dart';
import 'dna.dart';
import 'vector_2d.dart';

class GASimulation extends ChangeNotifier {
  bool running = false;
  late Bloop bloop;

  static const double width = 1000.0;
  static const double height = 500.0;

  late List<List<double>> noise2D;
  double noiseFrequency = 0.015;
  int noiseOctaves = 5;

  GASimulation() {
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

    configure();
  }

  void configure() {
    bloop = Bloop.create(
      noise2D,
      width,
      height,
      Vector2D(width / 2, height / 2),
      DNA(),
      10.1,
      15.0,
    );
  }

  void start() {
    running = true;
  }

  void stop() {
    running = false;
  }

  void run() async {
    Future.doWhile(() async {
      update();
      await Future.delayed(const Duration(milliseconds: 16));
      return running;
    });
  }

  void update() {
    bloop.update();

    // Triggers Custom painter to paint.
    notifyListeners();
  }
}
