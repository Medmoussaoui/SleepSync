import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final CustomIcon? icon;
  final void Function()? onPressed;

  const CustomRoundedButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = icon ?? SizedBox.shrink();
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      height: 46,
      color: color ?? AppColors.primaryBtnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          icon != null ? SizedBox(width: 8) : SizedBox.shrink(),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
