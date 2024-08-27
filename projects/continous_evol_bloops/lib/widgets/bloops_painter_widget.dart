import 'package:flutter/material.dart';

import 'border_clip_path.dart';

class BloopsPainterWidget extends StatefulWidget {
  final double height;
  final double width;
  final Color bgColor;

  const BloopsPainterWidget({
    super.key,
    required this.height,
    required this.width,
    required this.bgColor,
  });

  @override
  State<BloopsPainterWidget> createState() => _BloopsPainterWidgetState();
}

class _BloopsPainterWidgetState extends State<BloopsPainterWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BorderClipPath(),
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.bgColor,
        child: CustomPaint(
          painter: BloopsPainter(),
        ),
      ),
    );
  }
}

class BloopsPainter extends CustomPainter {
  final strokeWidth = 1.0;

  late Paint linePaint;
  late Paint linePaint2;

  BloopsPainter() {
    linePaint = Paint()
      ..color = const Color.fromARGB(100, 100, 100, 100)
      ..strokeWidth = strokeWidth;
    linePaint2 = Paint()
      ..color = const Color.fromARGB(100, 50, 50, 50)
      ..strokeWidth = strokeWidth;
  }

  @override
  // Size is the physical size. <0,0> is top-left.
  void paint(Canvas canvas, Size size) {
    _draw(canvas, size, strokeWidth);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _draw(Canvas canvas, Size size, double strokeWidth) {
    canvas.drawCircle(const Offset(200, 200), 20, linePaint);
    canvas.drawCircle(const Offset(225, 225), 40, linePaint2);
    canvas.drawCircle(const Offset(0, 225), 40, linePaint2);
  }
}
