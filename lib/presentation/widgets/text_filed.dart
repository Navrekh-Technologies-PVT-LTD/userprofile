import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_style.dart';

hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

get getPrefixTextBoxContains => const BoxConstraints(minWidth: 0, minHeight: 0);

getPrefixTextIcon({required String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8, left: 16),
        child: Text(
          text,
          style: textFiledTextStyle,
        ),
      ),
    ],
  );
}

TextInputType get getNumberKeyBoardType => const TextInputType.numberWithOptions(decimal: true);

List<TextInputFormatter> get getDoubleInputFormatter => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
    ];

List<TextInputFormatter> get getIntegerInputFormatter => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];

List<TextInputFormatter> get getNumberInputFormatterWithLength10 => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
      LengthLimitingTextInputFormatter(10),
    ];

Widget customTextFiled({
  String? label,
  String? hintText,
  String? initialValue,
  FormFieldValidator? validator,
  TextInputType? keyboardType,
  TextEditingController? controller,
  bool? hasError,
  bool? obscureText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool? isDisable,
  bool? isSelected,
  bool autofocus = false,
  Color? fillColor,
  int? maxLength,
  int? minLines,
  int? maxLines,
  ValueChanged<String>? onChanged,
  VoidCallback? onTap,
  bool? readOnly,
  EdgeInsetsGeometry? contentPadding,
  BorderRadius? borderRadius,
  Color? hintTextColor,
  Color? borderColor,
  String? prefixText,
  BoxConstraints? prefixIconConstraints,
  BoxConstraints? suffixIconConstraints,
  List<TextInputFormatter>? inputFormatters,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextInputAction? textInputAction,
  Function(String)? onFieldSubmitted,
  FocusNode? focusNode,
  TextAlign textAlign = TextAlign.start,
}) {
  return TextFormField(
    initialValue: initialValue,
    autofocus: autofocus,
    textAlign: textAlign,
    focusNode: focusNode,
    onFieldSubmitted: onFieldSubmitted,
    textInputAction: textInputAction,
    textCapitalization: textCapitalization,
    controller: controller,
    keyboardType: keyboardType ?? TextInputType.text,
    style: isDisable == true ? disableTextFiledTextStyle : textFiledTextStyle,
    validator: validator,
    onChanged: onChanged,
    onTap: onTap,
    readOnly: readOnly ?? false,
    minLines: minLines,
    maxLines: maxLines,
    maxLength: maxLength,
    obscureText: obscureText ?? false,
    inputFormatters: inputFormatters,
    decoration: getTextFiledDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      label: label,
      prefixIcon: prefixIcon,
      hasError: hasError,
      isDisable: isDisable,
      isSelected: isSelected,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      fillColor: fillColor,
      hintTextColor: hintTextColor,
      borderColor: borderColor,
      prefixText: prefixText,
      prefixIconConstraints: prefixIconConstraints,
      suffixIconConstraints: suffixIconConstraints,
    ),
  );
}

Widget customDropDownFiled(
    {String? label,
    String? hintText,
    FormFieldValidator? validator,
    TextInputType? keyboardType,
    TextEditingController? controller,
    Widget? suffixIcon,
    Color? borderColor,
    bool? hasError,
    bool? readOnly,
    dynamic value,
    bool? isDisable,
    required ValueChanged onChanged,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    required List<DropdownMenuItem> items}) {
  return DropdownButtonFormField(
    dropdownColor: TColor.white,
    menuMaxHeight: 400,
    value: value,
    onChanged: readOnly == true ? null : onChanged,
    items: items,
    style: isDisable == true ? disableTextFiledTextStyle : textFiledTextStyle,
    borderRadius: BorderRadius.circular(10),
    validator: validator,
    hint: hintText != null
        ? Text(
            hintText,
            style: hintTextFiledTextStyle,
          )
        : null,
    icon: readOnly == true
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SvgPicture.asset(
              "assets/images/arrow_down.svg",
              height: 10,
              width: 10,
            ),
          ),
    decoration: getTextFiledDecoration(
      contentPadding: contentPadding,
      suffixIcon: suffixIcon,
      hintText: null,
      label: label,
      hasError: hasError,
      isDisable: isDisable,
      borderColor: borderColor,
      fillColor: fillColor,
    ),
  );
}

DropdownMenuItem customDropDownMenuItem(
    {required String title, required dynamic value, Color? titleColor}) {
  return DropdownMenuItem(
    value: value,
    child: Text(
      title,
      style: textFiledTextStyle.copyWith(color: titleColor),
    ),
  );
}

getTextFiledDecoration({
  String? label,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? hintText,
  String? prefixText,
  bool? hasError,
  bool? isDisable,
  bool? isSelected,
  EdgeInsetsGeometry? contentPadding,
  BorderRadius? borderRadius,
  Color? hintTextColor,
  Color? fillColor,
  Color? borderColor,
  BoxConstraints? prefixIconConstraints,
  BoxConstraints? suffixIconConstraints,
}) {
  BorderRadius finalBorderRadius = borderRadius ?? BorderRadius.circular(10);

  return InputDecoration(
    errorMaxLines: 2,
    enabled: !(isDisable ?? false),
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    prefixText: prefixText,
    prefixIcon: prefixIcon,
    prefixIconConstraints: prefixIconConstraints,
    suffixIconConstraints: suffixIconConstraints,
    suffixIcon: suffixIcon,
    labelStyle: labelTextFiledTextStyle,
    // labelText: label,
    label: label != null
        ? RichText(
            text: TextSpan(
              style: labelTextFiledTextStyle,
              children: <TextSpan>[
                TextSpan(
                  text: (label).replaceAll("*", ""),
                ),
                if ((label).contains("*"))
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: redColor),
                  ),
              ],
            ),
          )
        : null,
    hintText: hintText,
    hintStyle: hintTextFiledTextStyle,
    errorStyle: GoogleFonts.inter(
      color: errorColor,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    filled: true,
    fillColor: fillColor ?? Colors.white,
    contentPadding:
        contentPadding ?? const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 12),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: TColor.msgbck, width: 1.5),
      borderRadius: finalBorderRadius,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: borderColor ?? (isSelected == true ? TColor.msgbck : TColor.borderColor)),
      borderRadius: finalBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor),
      borderRadius: finalBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor),
      borderRadius: finalBorderRadius,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? TColor.borderColor),
      borderRadius: finalBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? (isSelected == true ? TColor.msgbck : TColor.borderColor),
      ),
      borderRadius: finalBorderRadius,
    ),
    counterStyle: const TextStyle(fontSize: 0),
    counterText: "",
  );
}

customDropDownArrow() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        "assets/images/arrow_down.svg",
        height: 18,
      ),
    ],
  );
}
