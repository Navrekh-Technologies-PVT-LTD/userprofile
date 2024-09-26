import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/utils/color.dart';

customAppBarForTournament(
    {required BuildContext context, required String title, VoidCallback? onBack}) {
  return AppBar(
    elevation: 10,
    leading: IconButton(
      onPressed: onBack ??
          () {
            Navigator.pop(context);
          },
      icon: SvgPicture.asset("assets/images/back_arrow.svg"),
    ),
    title: Text(
      title,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    backgroundColor: TColor.white,
    surfaceTintColor: TColor.white,
    titleSpacing: -8,
  );
}
