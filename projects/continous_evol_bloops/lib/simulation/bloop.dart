import 'dart:math';
import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:num_remap/num_remap.dart';

import 'dna.dart';
import 'vector_2d.dart';

class Bloop {
  static const double width = 1000.0;
  static const double height = 500.0;
  static const double size = width * height;

  Random rando = Random();
  late List<List<double>> noise2D;

  late Vector2D position;
  late DNA dna;

  int health = 200;
  late double xOff;
  late double yOff;

  double maxSpeed = 0.0;
  double r = 1.0; // radius

  Bloop();

  factory Bloop.create(Vector2D position, DNA dna) {
    Bloop bloop = Bloop()
      ..position = position
      ..dna = dna
      // DNA will determine size and maxspeed
      // The bigger the bloop, the slower it is
      ..maxSpeed = 1.1 //dna.genes[0].remap(0, 1, 15, 0)
      ..r = 15.0 //dna.genes[0].remap(0, 1, 0, 25)
      // Generate a 1D array using a 1x(N*M) array
      ..noise2D = noise2(
        (width * height).toInt(),
        1,
        // width.toInt(),
        // height.toInt(),
        noiseType: NoiseType.perlin,
        frequency: 0.015,
        octaves: 5,
        cellularReturnType: CellularReturnType.distance,
      );

    bloop.configure();

    return bloop;
  }

  void configure() {
    xOff = width / 2;
    yOff = height / 2;
    // xOff = rando.nextDouble() * (width * height - 1);
    // yOff = rando.nextDouble() * (width * height - 1);
  }

  void update() {
    //
    // Simple movement based on perlin noise
    int ix = xOff.floor();
    int iy = yOff.floor();

    double vx = noise2D[ix][0].remap(-1, 1, -maxSpeed, maxSpeed);
    double vy = noise2D[iy][0].remap(-1, 1, -maxSpeed, maxSpeed);
    xOff += 0.1; // * rando.nextDouble();
    yOff += 0.1; // * rando.nextDouble();
    if (xOff > width - 1) xOff = 0;
    if (yOff > height - 1) yOff = 0;
    // if (xOff > size - 1) xOff = 0;
    // if (yOff > size - 1) yOff = 0;

    position.add(vx, vy);

    if (position.x < -r) position.x = width + r;
    if (position.y < r) position.y = height + r;
    if (position.x > width + r) position.x = -r;
    if (position.y > height + r) position.y = -r;
  }
}
