import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/view/onBoarding/see_the_sience.dart';

class OnBoardingProgress extends StatelessWidget {
  final void Function()? onTap;
  final int steep;

  const OnBoardingProgress({super.key, this.onTap, required this.steep});

  @override
  Widget build(BuildContext context) {
    double begin = 1 / 4;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: begin, end: (begin * steep).toDouble()),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  builder: (context, value, _) {
                    return CircularProgressIndicator(
                      color: AppColors.primaryTextColor,
                      strokeWidth: 1.5,
                      value: value,
                      backgroundColor:
                          AppColors.primaryTextColor.withOpacity(0.2),
                    );
                  },
                ),
              ),
              MaterialButton(
                height: 56,
                minWidth: 56,
                shape: CircleBorder(),
                color: AppColors.primaryTextColor,
                onPressed: () => onTap!(),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.backgroundColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        SeeTheSience(),
      ],
    );
  }
}
