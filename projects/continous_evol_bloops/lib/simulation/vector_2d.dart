class Vector2D {
  double x = 0.0;
  double y = 0.0;

  Vector2D(this.x, this.y);

  void add(double x, double y) {
    this.x += x;
    this.y += y;
  }

  void addByVector(Vector2D v) {
    x += v.x;
    y += v.y;
  }
}
