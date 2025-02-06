
import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class SeeTheSience extends StatelessWidget {
  const SeeTheSience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "See the sience",
      style: TextStyle(
        fontSize: 12.0,
        color: AppColors.accentTextColor,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
