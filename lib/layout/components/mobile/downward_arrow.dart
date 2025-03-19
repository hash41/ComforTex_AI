import 'package:flutter/material.dart';

class DownwardArrow extends CustomPainter {
  // Optional: if you want an outline

  DownwardArrow({this.color = Colors.grey, this.strokeWidth = 0.0});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle
          .stroke; //A line has no area to fill,
                    // thus we use PaintingStyle.stroke
    final path = Path()
      ..moveTo(size.width * 1 / 2, size.height * 1 / 5)
      ..lineTo(size.width * 1 / 2, size.height * 4 / 5)
      ..close();
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;
    path
      ..moveTo(size.width * 1 / 2, size.height * 3.9 / 5)
      ..lineTo(size.width * 2 / 3, size.height * 3.9 / 5)
      ..lineTo(size.width * 1 / 2, size.height)
      ..lineTo(size.width * 1 / 3, size.height * 3.9 / 5)
      ..lineTo(size.width * 1 / 2, size.height * 3.9 / 5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DownwardArrow oldDelegate) {
    // Repaint only if the color or stroke width changes.
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
