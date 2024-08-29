import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'vector_2d.dart';

class Food {
  late Random rando;

  double width = 0.0;
  double height = 0.0;

  // The genetic sequence
  // DNA is random floating point values between 0 and 1 (!!)
  List<Vector2D> foodPositions = [];
  late Paint foodFillPaint;
  late Paint foodBorderPaint;

  Food();

  factory Food.create(
      int foodCount, double width, double height, Random rando) {
    Food food = Food()
      ..rando = rando
      ..width = width
      ..height = height;

    food.foodPositions.clear();

    for (var i = 0; i < foodCount; i++) {
      food.foodPositions.add(
        food.generatePosition(),
      );
    }

    food.foodFillPaint = Paint()
      ..color = Colors.green.shade200
      ..strokeWidth = 2;
    food.foodBorderPaint = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    return food;
  }

  Vector2D generatePosition() {
    return Vector2D(
      rando.nextDouble() * width,
      rando.nextDouble() * height,
    );
  }

  /// Some agent just died. replace with body remains
  /// aka food.
  void add(Vector2D positin) {
    foodPositions.add(positin.copy());
  }

  void update() {
    // There's a small chance food will appear randomly
    if (rando.nextDouble() < 0.001) {
      foodPositions.add(generatePosition());
    }
  }

  void draw(Canvas canvas, Size size) {
    for (var i = 0; i < foodPositions.length; i++) {
      var position = foodPositions[i];
      Rect rect = Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: 8,
        height: 8,
      );

      canvas.drawRect(rect, foodFillPaint);
      canvas.drawRect(rect, foodBorderPaint);
    }
  }
}
