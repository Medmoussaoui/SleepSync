import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? leadingIcon;
  final Widget? trailingWidget;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color textColor;
  final Color subtitleColor;
  final bool? padding;

  const CustomTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.leadingIcon,
    this.trailingWidget,
    this.borderColor,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.subtitleColor = Colors.grey,
    this.padding = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: Container(
        padding: padding == true ? const EdgeInsets.all(12) : null,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Leading Custom Icon
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: 12)
            ],
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headline5regular,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.subtitle4Light,
                    ),
                ],
              ),
            ),

            // Custom Trailing Widget
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
