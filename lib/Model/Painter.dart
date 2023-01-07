import 'package:flutter/material.dart';

import 'model.dart';

class MyPainter extends CustomPainter {
  late List<DrawingModel?> Points;

  MyPainter({
    required this.Points,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // var paint = Paint()
    //   ..color = ColorLine
    //   ..strokeWidth = StrokeWidth
    //   ..strokeCap = StrokeCap.butt;

    for (var i = 0; i < (Points.length - 1); i++) {
      var currentPoint = Points[i];
      var nextPoint = Points[i + 1];
      if (currentPoint != null && nextPoint != null) {
        canvas.drawLine(
          currentPoint.ponts,
          nextPoint.ponts,
          currentPoint.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
