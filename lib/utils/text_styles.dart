import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class AppTextStyles {
  ///
  /// Headlines
  ///
  static TextStyle headline1medium = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline2bold = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headline2medium = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline3medium = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline3regular = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headline4medium = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline5regular = GoogleFonts.poppins(
    color: AppColors.primaryTextColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  ///
  /// SubTitles
  ///
  static TextStyle subtitle1Regular = GoogleFonts.poppins(
    color: AppColors.secondaryTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subtitle2Regular = GoogleFonts.poppins(
    color: AppColors.secondaryTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subtitle3Light = GoogleFonts.poppins(
    color: AppColors.secondaryTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static TextStyle subtitle4Regular = GoogleFonts.poppins(
    color: AppColors.secondaryTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subtitle4Light = GoogleFonts.poppins(
    color: AppColors.secondaryTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
}
