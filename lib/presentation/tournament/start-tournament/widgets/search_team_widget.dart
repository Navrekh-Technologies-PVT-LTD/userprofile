import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class SearchTeamWidget extends StatelessWidget {
  final TournamentProvider tournamentState;
  const SearchTeamWidget({super.key, required this.tournamentState});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        tournamentState.searchTeamFilterText(value);
      },
      style: subHeadingStyle.copyWith(
        fontSize: 12.sp,
        color: TColor.greyText,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF2F2F2),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: TColor.borderColor,
            width: 0.33.r,
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: TColor.borderColor,
            width: 0.33.r,
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: TColor.borderColor,
            width: 0.33.r,
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: TColor.greyText,
        ),
        hintText: "Search Team",
        hintStyle: subHeadingStyle.copyWith(
          fontSize: 12.sp,
          color: TColor.greyText,
        ),
      ),
    );
  }
}
