import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

/// Curved grey container TextField
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.focusNode,
    this.maxLength,
    this.enabled,
    this.height,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.controller,
    this.margin,
    this.onSubmitted,
    this.hintText,
    this.hintTextStyle,
    this.fillColor,
    this.textInputType,
    this.maxLines,
    this.validator,
    this.autoFocus,
    this.minLines,
    this.obscureText = false,
    this.onTap,
    this.contentPadding,
  });
  final FocusNode? focusNode;
  final int? maxLength;
  final bool? enabled;
  final String? hintText;
  final double? height;
  final Widget? suffix;
  final Widget? prefix;
  final EdgeInsetsGeometry? contentPadding;
  final bool? autoFocus;
  final int? minLines;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final Function(String value)? onSubmitted;
  final TextStyle? hintTextStyle;
  final Color? fillColor;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      child: TextFormField(
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        style: subHeadingStyle.copyWith(
          color: TColor.greyText.withOpacity(0.50),
          fontSize: 10.sp,
        ),
        enabled: enabled ?? true,
        cursorColor: Colors.black,
        minLines: minLines,
        autofocus: autoFocus ?? false,
        maxLength: maxLength,
        keyboardType: textInputType,
        onChanged: onChanged,
        onTap: onTap,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          fillColor: fillColor ?? Colors.white,
          filled: true,
          contentPadding:
              contentPadding ?? EdgeInsets.only(left: 20.w, right: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:
                BorderSide(color: const Color(0xff7a7a7a), width: 0.33.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:
                BorderSide(color: const Color(0xff7a7a7a), width: 0.33.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:
                BorderSide(color: const Color(0xff7a7a7a), width: 0.33.w),
          ),
          suffixIcon: suffix,
          prefixIcon: prefix,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: hintTextStyle ??
              subHeadingStyle.copyWith(
                color: TColor.greyText.withOpacity(0.50),
                fontSize: 10.sp,
              ),
        ),
      ),
    );
  }
}
