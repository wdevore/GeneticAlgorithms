import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../simulation/simulation.dart';
import '../simulation/vector_2d.dart';
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
        child: Consumer<GASimulation>(
          builder: (BuildContext context, GASimulation value, Widget? child) {
            return CustomPaint(
              painter: BloopsPainter(value),
            );
          },
        ),
      ),
    );
  }
}

class BloopsPainter extends CustomPainter {
  final GASimulation simulation;
  final strokeWidth = 1.0;

  late Paint linePaint;
  late Paint linePaint2;

  BloopsPainter(this.simulation) {
    linePaint = Paint()
      ..color = const Color.fromARGB(100, 100, 100, 100)
      ..strokeWidth = strokeWidth;
    linePaint2 = Paint()
      ..color = const Color.fromARGB(100, 50, 50, 50)
      ..style = PaintingStyle.stroke
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
    Vector2D position = simulation.bloop.position;

    canvas.drawCircle(
        Offset(position.x, position.y), simulation.bloop.r, linePaint);
  }
}
