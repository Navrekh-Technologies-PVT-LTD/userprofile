import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class TournamentDatesWidget extends StatelessWidget {
  final TournamentProvider tournamentState;
  const TournamentDatesWidget({super.key, required this.tournamentState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonContainer(
            onTap: () {
              tournamentState.selectStartDate(context);
            },
            height: 40.h,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: TColor.borderColor, width: 0.33.w),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tournamentState.startDate,
                    style: subHeadingStyle.copyWith(
                      fontSize: 12.sp,
                      color: TColor.greyText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CommonContainer(
            onTap: () {
              tournamentState.selectEndDate(context);
            },
            height: 40.h,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: TColor.borderColor, width: 0.33.w),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tournamentState.endDate,
                    style: subHeadingStyle.copyWith(
                      fontSize: 12.sp,
                      color: TColor.greyText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
