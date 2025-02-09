import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SemiCircularProgressBar extends StatefulWidget {
  final double progress; // Progress from 0.0 to 1.0
  final int completedCycles;
  final int totalCycles;

  const SemiCircularProgressBar({
    super.key,
    required this.progress,
    required this.completedCycles,
    required this.totalCycles,
  });

  @override
  SemiCircularProgressBarState createState() => SemiCircularProgressBarState();
}

class SemiCircularProgressBarState extends State<SemiCircularProgressBar> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: widget.progress),
      duration: const Duration(seconds: 1), // Smooth animation duration
      curve: Curves.easeOut, // Smooth easing effect
      builder: (context, animatedProgress, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomPaint(
              size: const Size(280, 190), // Semi-circle size
              painter: _SemiCirclePainter(animatedProgress),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "cycles",
                    style: AppTextStyles.subtitle4Regular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryTextColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "${(animatedProgress * 100).round()}%",
                    style: AppTextStyles.headline2bold.copyWith(fontSize: 40),
                  ),
                  Text(
                    "Completed (${widget.completedCycles}/${widget.totalCycles})",
                    style: AppTextStyles.subtitle2Regular.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryTextColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final double progress;

  _SemiCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = AppColors.white.withOpacity(0.05)
      ..strokeWidth = 17
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = AppColors.blue
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
