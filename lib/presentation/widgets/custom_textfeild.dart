import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TextFieldCustom extends StatelessWidget {
  final String? labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmit;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final String? hintText;
  final VoidCallback? onTapSuffixIcon;
  final VoidCallback? onTapPrefixIcon;
  final IconData? suffixIconData;
  final IconData? prefixIconData;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final Widget? prefixWidget;
  final TextInputType? inputType;
  final bool? obscureText;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final bool? borderSide;
  final String? errorText;
  final String? initialValue;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextAlign? textAlign;
  final int? maxLength;

  static const Color _textFieldThemeColor = Color(0xff3d475a);

  const TextFieldCustom({
    this.textAlign,
    this.readOnly = false,
    this.inputFormatters,
    this.labelText,
    required this.controller,
    this.validator,
    this.onFieldSubmit,
    this.hintText,
    this.onTapSuffixIcon,
    this.suffixIconData,
    this.prefixIconData,
    this.onTapPrefixIcon,
    this.focusNode,
    this.backgroundColor = Colors.white,
    this.hintTextColor = _textFieldThemeColor,
    this.cursorColor = _textFieldThemeColor,
    this.textColor = _textFieldThemeColor,
    this.prefixIconColor = const Color(0xff3d475a),
    this.sufixIconColor = const Color(0xff3d475a),
    this.borderColor = const Color(0xff79747E),
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 5,
    this.borderSide = false,
    this.onTap,
    this.onChanged,
    this.errorText,
    this.initialValue,
    this.borderWidth = 1,
    this.maxLines = 1,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      readOnly: readOnly!,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText!,
      keyboardType: inputType,
      focusNode: focusNode,
      validator: validator,
      cursorWidth: 1,
      cursorColor: cursorColor,
      autofocus: false,
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          decoration: TextDecoration.none,
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500),
      onFieldSubmitted: onFieldSubmit,
      decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          errorMaxLines: 3,
          hoverColor: Colors.white,
          errorText: errorText,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white10,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: hintTextColor),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w, vertical: maxLines! > 1 ? 8.h : 2.h),
          suffixIcon: suffixIconData == null
              ? null
              : GestureDetector(
            onTap: onTapSuffixIcon!,
            child: Icon(
              suffixIconData,
              size: 20.sp,
              color: sufixIconColor,
            ),
          ),
          //prefix: prefixWidget,
          prefixIconConstraints:
          BoxConstraints.tight(const Size.fromRadius(12)),
          prefixIcon: prefixWidget ??
              (prefixIconData == null
                  ? null
                  : GestureDetector(
                onTap: onTapPrefixIcon!,
                child: Icon(
                  prefixIconData,
                  size: 16.sp,
                  color: prefixIconColor,
                ),
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: borderSide == true
                ? BorderSide(
              color: borderColor!,
            )
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: borderSide == true
                ? BorderSide(color: borderColor!, width: borderWidth!)
                : BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: borderSide == true
                ? BorderSide(color: borderColor!, width: borderWidth!)
                : BorderSide.none,
          )),
      //  ),
    );
  }
}