import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class PlayerPerformanceItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const PlayerPerformanceItem(
      {required this.title,
      required this.isSelected,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CommonContainer(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
        borderRadius: BorderRadius.circular(16),
        color: isSelected == true ? TColor.msgbck : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected == true ? Colors.white : TColor.greyText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
