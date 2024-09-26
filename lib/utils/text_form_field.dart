import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customTextFormField(controller, text, hintText) {
  return Padding(
    padding: EdgeInsets.only(
      right: 12.0.w,
      left: 12.0.w,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          ),
        ),
      ],
    ),
  );
}

customTextFormFieldKickOff(BuildContext context, controller, hintText,
    {double topPadding = 5.0,
    text = "",
    bool addIcon = false,
    icon,
    void Function()? onPressed}) {
  return Padding(
    padding: EdgeInsets.only(
      top: topPadding,
      right: 12.0.w,
      left: 12.0.w,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.10,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 235, 235),
              hintText: hintText ?? "",
              hintStyle: TextStyle(fontSize: 12.sp),
              suffixIcon: addIcon
                  ? IconButton(icon: Icon(icon!), onPressed: onPressed)
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.r),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            ),
          ),
        ),
      ],
    ),
  );
}
