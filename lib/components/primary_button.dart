import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0.0, 4),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Color(0xff713E84),
            ),
          ),
        ),
        MaterialButton(
          elevation: 0,
          onPressed: onPressed,
          height: 56,
          minWidth: double.infinity,
          color: color ?? AppColors.primaryBtnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
