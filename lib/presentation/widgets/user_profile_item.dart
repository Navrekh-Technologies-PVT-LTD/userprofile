import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class UserProfileItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const UserProfileItem(
      {required this.title,
      required this.isSelected,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CommonContainer(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
        border: Border.all(color: TColor.borderColor, width: 0.33),
        borderRadius: BorderRadius.circular(16),
        color: isSelected == true ? TColor.msgbck : Colors.white,
        child: Center(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 10,
                color: isSelected == true ? Colors.white : TColor.greyText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
