import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final Widget action;

  const CustomBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            title,
            style: AppTextStyles.subtitle4Light,
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: content,
        ),
        action,
      ],
    );
  }
}
