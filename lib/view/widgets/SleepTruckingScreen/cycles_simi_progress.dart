import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/components/sleep_progress_ndicator.dart';
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
              painter: SemiCirclePainter(animatedProgress),
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
                      // color: AppColors.secondaryTextColor.withOpacity(0.5),
                      color: AppColors.relaxGrey.withOpacity(0.5),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: 450.ms,
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: Text(
                      "${(animatedProgress * 100).round()}%",
                      style: AppTextStyles.headline2bold.copyWith(
                        fontSize: 40,
                        color: AppColors.relaxWhite.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Text(
                    "Completed (${widget.completedCycles}/${widget.totalCycles})",
                    style: AppTextStyles.subtitle2Regular.copyWith(
                      fontSize: 14,
                      // color: AppColors.secondaryTextColor.withOpacity(0.8),
                      color: AppColors.relaxGrey.withOpacity(0.8),
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
