

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget  CustomPlayerWidget({required String image, required  String plalyname, required  String plalyid}){
  return Container(
     padding: EdgeInsets.all(5.h),
    height: 40.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
        ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(image),
            SizedBox(width: 5.w,),
            Text(plalyname)
          ],
        ),
        plalyid=='1' && plalyname=='Tavnir Ahmed'? Container(
          height: 20.h,
          width: 20.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF007AFF),
            borderRadius: BorderRadius.circular(100)
          ),
          child:  Icon(Icons.check,color: Colors.white,size: 15,),
        ):SizedBox(),
      ],
    ),
  );

}