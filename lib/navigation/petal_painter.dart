import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Color color;

  MyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = color;
    path = Path();
    path.lineTo(size.width * 0.01, size.height * 0.13);
    path.cubicTo(-0.01, size.height * 0.09, size.width * 0.03,
        size.height * 0.04, size.width * 0.1, size.height * 0.03);
    path.cubicTo(size.width / 5, size.height * 0.02, size.width * 0.35, 0,
        size.width * 0.51, 0);
    path.cubicTo(size.width * 0.66, 0, size.width * 0.81, size.height * 0.02,
        size.width * 0.91, size.height * 0.03);
    path.cubicTo(size.width * 0.98, size.height * 0.04, size.width,
        size.height * 0.08, size.width, size.height * 0.13);
    path.cubicTo(size.width, size.height * 0.13, size.width * 0.65,
        size.height * 0.94, size.width * 0.65, size.height * 0.94);
    path.cubicTo(size.width * 0.64, size.height * 0.98, size.width * 0.59,
        size.height, size.width * 0.53, size.height);
    path.cubicTo(size.width * 0.53, size.height, size.width / 2, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.45, size.height, size.width * 0.4,
        size.height * 0.98, size.width * 0.38, size.height * 0.94);
    path.cubicTo(size.width * 0.38, size.height * 0.94, size.width * 0.01,
        size.height * 0.13, size.width * 0.01, size.height * 0.13);
    path.cubicTo(size.width * 0.01, size.height * 0.13, size.width * 0.01,
        size.height * 0.13, size.width * 0.01, size.height * 0.13);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
