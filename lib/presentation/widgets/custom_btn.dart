import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/utils/color.dart';

customButtonForTournament({
  required String title,
  VoidCallback? onTap,
  EdgeInsetsGeometry? margin,
  double width = double.infinity,
  double height = 40,
  bool isOutLine = false,
  bool isLoading = false,
  FontWeight fontWeight = FontWeight.w500,
  double fontSize = 16,
}) {
  return Container(
    padding: margin,
    child: GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isOutLine ? TColor.white : TColor.msgbck,
          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
          border: Border.all(
            color: isOutLine ? TColor.msgbck2 : TColor.msgbck,
          ),
        ),
        child: Center(
          child: isLoading
              ? Transform.scale(
                  scale: 0.5,
                  child: CircularProgressIndicator(
                    color: isOutLine ? TColor.msgbck : TColor.white,
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: fontSize,
                    color: isOutLine ? TColor.msgbck2 : Colors.white,
                    fontWeight: fontWeight,
                  ),
                ),
        ),
      ),
    ),
  );
}
