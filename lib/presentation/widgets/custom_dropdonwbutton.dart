import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/locale_keys.g.dart';
import 'custom_player_widged.dart';

class CustomDropdownButton extends StatefulWidget {
  final String? hint;
  final List<String> itemList;

  const CustomDropdownButton({super.key, this.hint, required this.itemList});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
       margin: EdgeInsets.symmetric(vertical: 1.w),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            )),
        padding: _selectedValue != null? null:EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: DropdownButton<String>(
          icon: _selectedValue != null? SizedBox.shrink():Icon(Icons.arrow_drop_down),
          isExpanded: true,
          hint: Text(widget.hint ?? tr(LocaleKeys.select_s),
          //"Select",
              style: TextStyle(fontSize: 12.sp)),
          value: _selectedValue,
          items: widget.itemList.map((value) {
            return DropdownMenuItem<String>(
              child: CustomPlayerWidget(plalyname: value, image: "assets/images/playerimage.png", plalyid: '1'),
              value: value,
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
      ),
    );
  }
}