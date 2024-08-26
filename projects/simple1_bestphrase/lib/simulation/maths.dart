import 'dart:math';

class Maths {
  static Random rando = Random();

  static int randomRange(int from, int to) {
    int ran = rando.nextInt(to - from) + from;
    return ran;
  }

  static double randomRangeDouble(double from, double to) {
    double ran = rando.nextDouble() * (to - from) + from;
    return ran;
  }
}
