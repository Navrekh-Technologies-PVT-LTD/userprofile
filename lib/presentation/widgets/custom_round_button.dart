import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/utils/color.dart';

enum CustomRoundButtonType {
  bgPrimary,
  textPrimary,
}

class CustomRoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final CustomRoundButtonType type;
  final double fontSize;
  final Color buttonColor;

  const CustomRoundButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.fontSize = 16,
      required this.buttonColor,
      this.type = CustomRoundButtonType.bgPrimary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: type == CustomRoundButtonType.bgPrimary
              ? null
              : Border.all(color: buttonColor, width: 1),
          color: type == CustomRoundButtonType.bgPrimary
              ? buttonColor
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: GoogleFonts.inter(
                color: type == CustomRoundButtonType.bgPrimary
                    ? Colors.white
                    : buttonColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
