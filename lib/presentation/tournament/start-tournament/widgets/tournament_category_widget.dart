import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class TournamentCategoryWidget extends StatelessWidget {
  final TournamentProvider tournamentState;
  const TournamentCategoryWidget({super.key, required this.tournamentState});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10.w,
      spacing: 10.w,
      children: [
        ...tournamentState.tournamentCatList.map((value) {
          return IntrinsicWidth(
            child: InkWell(
              onTap: () {
                tournamentState.selectTournamentCategory(value);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: tournamentState.selectedTournamentCategory == value
                      ? const Color(0xff554585)
                      : Colors.white,
                  border: Border.all(
                    width: 0.33.w,
                    color: TColor.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Add this line to make Row take minimum width
                  children: [
                    Text(
                      value,
                      style: subHeadingStyle.copyWith(
                        fontSize: 14.sp,
                        color:
                            tournamentState.selectedTournamentCategory == value
                                ? Colors.white
                                : TColor.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
