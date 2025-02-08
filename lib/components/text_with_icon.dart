import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Widget icon;

  const TextWithIcon(
      {super.key, required this.text, required this.icon, this.style});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.ms,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Row(
        key: ValueKey(text),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 5),
          Text(
            text,
            style: style ??
                AppTextStyles.headline3medium.copyWith(
                  color: AppColors.blue,
                ),
          ),
        ],
      ),
    );
  }
}
