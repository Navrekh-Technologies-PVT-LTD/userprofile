import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/utils/color.dart';

const sfProDisplayFontFamily = "sf-pro-display";

/// Text Filed Style

TextStyle get textFiledTextStyle => TextStyle(
      color: TColor.greyText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: sfProDisplayFontFamily,
    );

TextStyle get disableTextFiledTextStyle => TextStyle(
      color: TColor.greyText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: sfProDisplayFontFamily,
    );

TextStyle get hintTextFiledTextStyle => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: TColor.greyText,
      fontFamily: sfProDisplayFontFamily,
    );

TextStyle get labelTextFiledTextStyle => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: TColor.greyText,
      fontFamily: sfProDisplayFontFamily,
    );

/// Inter

TextStyle get style14500BlackInter => GoogleFonts.inter(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );

TextStyle get style16500BlackInter => GoogleFonts.inter(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

TextStyle get style20500WhiteInter => GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

TextStyle get style12500GreyDAInter => GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: TColor.greyDA,
    );

///  SF Pro Display

TextStyle get style16600BlackSFProDisplay => const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: sfProDisplayFontFamily,
    );

TextStyle get style10400GreySFProDisplay => TextStyle(
      color: TColor.greyText,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: sfProDisplayFontFamily,
    );

TextStyle get style12500GreySFProDisplay => TextStyle(
      color: TColor.greyText,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: sfProDisplayFontFamily,
    );
