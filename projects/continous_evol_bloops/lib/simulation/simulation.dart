import 'package:flutter/material.dart';

import 'bloop.dart';
import 'dna.dart';
import 'vector_2d.dart';

class GASimulation extends ChangeNotifier {
  bool running = false;
  late Bloop bloop;

  GASimulation() {
    bloop = Bloop.create(Vector2D(Bloop.width / 2, Bloop.height / 2), DNA());
  }

  void configure() {
    bloop.configure();
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
      await Future.delayed(const Duration(milliseconds: 10));
      return running;
    });
  }

  void update() {
    bloop.update();

    // Triggers Custom painter to paint.
    notifyListeners();
  }
}
