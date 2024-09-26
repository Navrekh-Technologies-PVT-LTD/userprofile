// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlertDialog(
    {required BuildContext context,
    required String title,
    required Widget Content,
    required List<Widget>? actions}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          content: Content,
          actions: actions,
        ),
      );
    },
  );
}
