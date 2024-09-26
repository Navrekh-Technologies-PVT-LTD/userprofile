


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../gen/locale_keys.g.dart';

Widget CustomScoreBarWedget(){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        height: 24.h,
        width: 65.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withOpacity(.5),
            borderRadius: BorderRadius.circular(5)),
        child: Text(tr(LocaleKeys.first_half_c),
         // "First Half",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            )),
      ),
      Row(
        children: [
          const Text(
            "0",
            style:
            TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            height: 20.h,
            width: 2.w,
            color: Colors.black,
          ),
          SizedBox(
            width: 5.w,
          ),
          const Text("0",
              style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
      Container(
        height: 24.h,
        width: 65.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withOpacity(.5),
            borderRadius: BorderRadius.circular(5)),
        child: Text("00:00",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            )),
      ),
    ],
  );
}