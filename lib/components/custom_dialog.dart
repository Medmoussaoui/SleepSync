import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final Widget action;

  const CustomDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred Background
        Listener(
          onPointerDown: (d) => Get.back(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7), // Blur effect
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ), // Background overlay
          ),
        ),
        // Dialog Content
        Align(
          alignment: Alignment.bottomCenter, // Align at the bottom center
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 13),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title & Subtitle
                  Text(
                    title,
                    style: AppTextStyles.headline5regular,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: AppTextStyles.subtitle4Light,
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: content,
                  ),
                  action,
                ],
              ),
            ),
          ),
        )
            .animate()
            .moveY(
              begin: 150,
              end: 0,
              duration: 500.ms,
              curve: Curves.fastEaseInToSlowEaseOut,
            )
            .fade(duration: 450.ms)
      ],
    );
  }
}
