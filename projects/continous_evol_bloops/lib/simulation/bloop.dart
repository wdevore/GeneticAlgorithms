import 'dart:math';
import 'package:num_remap/num_remap.dart';

import 'dna.dart';
import 'food.dart';
import 'vector_2d.dart';

class Bloop {
  late double width;
  late double height;
  late double size = width * height;

  // --------- Noise properties
  late List<List<double>> noise2D;
  double noiseIndexSteppingRate = 0.25;
  late double xOff;
  late double yOff;

  late Random rando;

  late Vector2D position;
  late DNA dna;

  double health = 255.0;

  late double maxSpeed;
  late double r; // radius

  Bloop();

  factory Bloop.create(
    Random rando,
    List<List<double>> noise2D,
    double canvasWidth,
    double canvasHeight,
    Vector2D position,
    DNA dna,
  ) {
    Bloop bloop = Bloop()
      ..noise2D = noise2D
      ..width = canvasWidth
      ..height = canvasHeight
      ..position = position
      ..dna = dna
      // DNA will determine size and maxspeed
      // The bigger the bloop, the slower it is
      ..maxSpeed = dna.genes[0].remap(0, 1, 15, 0)
      ..r = dna.genes[0].remap(0, 1, 0, 25)
      // Generate a 1D array using a 1x(N*M) array
      ..configure(rando);

    return bloop;
  }

  void configure(Random rando) {
    this.rando = rando;

    // xOff = width / 2;
    // yOff = height / 2;
    xOff = rando.nextDouble() * (width * height - 1);
    yOff = rando.nextDouble() * (width * height - 1);
  }

  bool get isDead => health < 0.0;

  void update() {
    // Simple movement based on perlin noise
    int ix = xOff.floor();
    int iy = yOff.floor();

    double vx = noise2D[ix][0].remap(-1, 1, -maxSpeed, maxSpeed);
    double vy = noise2D[iy][0].remap(-1, 1, -maxSpeed, maxSpeed);
    xOff += noiseIndexSteppingRate; // * rando.nextDouble();
    yOff += noiseIndexSteppingRate; // * rando.nextDouble();
    if (xOff > size - 1) xOff = 0;
    if (yOff > size - 1) yOff = 0;

    position.add(vx, vy);

    health -= 0.2;
    borders();
  }

  void borders() {
    if (position.x < -r * 2) {
      position.x = width + r * 2;
    } else if (position.y < r * 2) {
      position.y = height + r * 2;
    } else if (position.x > width + r * 2) {
      position.x = -r * 2;
    } else if (position.y > height + r * 2) {
      position.y = -r * 2;
    }
  }

  /// A bloop can find food and eat it
  void eat(Food food) {
    // Check all the food vectors
    List<Vector2D> foodPositions = food.foodPositions;

    for (var i = foodPositions.length - 1; i >= 0; i--) {
      // How far away is the bloop?
      double distance = position.distance(foodPositions[i]);

      // If the food is nearby
      if (distance < r * 2) {
        // Increase health and remove the food!
        // health += 100.0;
        health = min(255, health + 10.0);
        foodPositions.removeAt(i);
      }
    }
  }

  // At any moment there is a teeny, tiny chance a bloop will reproduce
  Bloop? reproduce() {
    // Single parent reproduction
    if (rando.nextDouble() < 0.0005) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy(rando)
        // Child DNA can mutate
        ..mutate(0.01, rando);

      return Bloop.create(
        rando,
        noise2D,
        width,
        height,
        position.copy(),
        childDNA,
      );
    } else {
      return null;
    }
  }
}
