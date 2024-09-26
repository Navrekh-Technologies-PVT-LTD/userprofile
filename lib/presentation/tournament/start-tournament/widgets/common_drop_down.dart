import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class CommonDropDown extends StatelessWidget {
  final double width;
  final double height;
  final List<String> items;
  final TextStyle? style;
  final dynamic value;
  final Function(String?) onchanged;
  const CommonDropDown({
    super.key,
    required this.width,
    required this.height,
    required this.items,
    this.value,
    required this.onchanged,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      //padding: EdgeInsets.only(left: Get.width * 0.01),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const SizedBox.shrink(),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          items: items.map((String caste) {
            return DropdownMenuItem<String>(
              value: caste,
              child: Text(
                caste,
                style: style ??
                    subHeadingStyle.copyWith(
                      color: TColor.greyText.withOpacity(0.50),
                      fontSize: 10.sp,
                    ),
              ),
            );
          }).toList(),
          value: value,
          onChanged: onchanged,
        ),
      ),
    );
  }
}
