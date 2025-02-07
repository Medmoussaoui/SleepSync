import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class OnBoardingContent extends StatelessWidget {
  final String assetImage;
  final double? imageSize;
  final String title;
  final String description;

  const OnBoardingContent({
    super.key,
    required this.assetImage,
    required this.title,
    required this.description,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // image
        Expanded(
          child: OnBoardingImage(assetImage: assetImage, imageSize: imageSize)
              .animate(delay: 300.ms)
              .fade(
                duration: 600.ms,
                curve: Curves.easeIn,
              ),
        ),
        Expanded(
          child: Column(
            children: [
              OnBoardingTitle(title: title)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.5, end: 0, curve: Curves.easeOut),
              SizedBox(height: 15),
              OnBoardingDescription(description: description)
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .slideY(begin: 0.5, end: 0, curve: Curves.easeOut)
  
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardingDescription extends StatelessWidget {
  const OnBoardingDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: GoogleFonts.inter(
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryTextColor,
        // fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class OnBoardingTitle extends StatelessWidget {
  const OnBoardingTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryTextColor,
        // fontWeight: FontWeight.w600,
      ),
    );
  }
}

class OnBoardingImage extends StatelessWidget {
  const OnBoardingImage({
    super.key,
    required this.assetImage,
    required this.imageSize,
  });

  final String assetImage;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        assetImage,
        height: imageSize ?? 180,
        width: imageSize ?? 180,
      ),
    );
  }
}
