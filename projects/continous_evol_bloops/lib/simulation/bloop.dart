import 'dart:math';
import 'package:num_remap/num_remap.dart';

import 'dna.dart';
import 'vector_2d.dart';

class Bloop {
  late double width;
  late double height;
  late double size = width * height;

  // --------- Noise properties
  late List<List<double>> noise2D;
  double noiseIndexSteppingRate = 0.5;
  late double xOff;
  late double yOff;

  Random rando = Random();

  late Vector2D position;
  late DNA dna;

  int health = 200;

  late double maxSpeed;
  late double r; // radius

  Bloop();

  factory Bloop.create(
    List<List<double>> noise2D,
    double canvasWidth,
    double canvasHeight,
    Vector2D position,
    DNA dna,
    double maxSpeed,
    double radius,
  ) {
    Bloop bloop = Bloop()
      ..noise2D = noise2D
      ..width = canvasWidth
      ..height = canvasHeight
      ..position = position
      ..dna = dna
      // DNA will determine size and maxspeed
      // The bigger the bloop, the slower it is
      ..maxSpeed = maxSpeed //dna.genes[0].remap(0, 1, 15, 0)
      ..r = radius //dna.genes[0].remap(0, 1, 0, 25)
      // Generate a 1D array using a 1x(N*M) array
      ..configure();

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
    xOff += noiseIndexSteppingRate; // * rando.nextDouble();
    yOff += noiseIndexSteppingRate; // * rando.nextDouble();
    if (xOff > size - 1) xOff = 0;
    if (yOff > size - 1) yOff = 0;

    position.add(vx, vy);

    if (position.x < -r) position.x = width + r;
    if (position.y < r) position.y = height + r;
    if (position.x > width + r) position.x = -r;
    if (position.y > height + r) position.y = -r;
  }
}
