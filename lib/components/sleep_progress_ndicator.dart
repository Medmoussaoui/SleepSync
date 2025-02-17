import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SemiCirclePainter extends CustomPainter {
  final double progress;

  SemiCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = AppColors.relaxWhite.withOpacity(0.1)
      ..strokeWidth = 17
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = AppColors.relaxBlue
      ..strokeWidth = 17
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from left
      pi, // Half-circle
      false,
      backgroundPaint,
    );

    // Draw animated progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from left
      pi * progress, // Smooth animated progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
