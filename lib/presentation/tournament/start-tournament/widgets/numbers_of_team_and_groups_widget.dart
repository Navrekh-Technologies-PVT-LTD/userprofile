import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/common_drop_down.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class NumbersOfTeamAndGroupsWidget extends StatelessWidget {
  final TournamentProvider tournamentState;
  const NumbersOfTeamAndGroupsWidget(
      {super.key, required this.tournamentState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Number of Teams",
          style: subHeadingStyle.copyWith(
            fontSize: 12.sp,
            color: TColor.greyText,
          ),
        ),
        SizedBox(height: 8.h),
        CommonContainer(
          height: 40.h,
          width: MediaQuery.sizeOf(context).width,
          border: Border.all(color: TColor.borderColor, width: 0.33.w),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                CommonDropDown(
                  height: 40.h,
                  width: 270.w,
                  value: tournamentState.selectedNumberOfTeam,
                  onchanged: (value) {
                    tournamentState.selectNumberOfTeams(value!);
                  },
                  items: tournamentState.numberOfTeams,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          "Number of Groups",
          style: subHeadingStyle.copyWith(
            fontSize: 12.sp,
            color: TColor.greyText,
          ),
        ),
        SizedBox(height: 8.h),
        CommonContainer(
          height: 40.h,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white,
          border: Border.all(color: TColor.borderColor, width: 0.33.w),
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                CommonDropDown(
                  height: 40.h,
                  onchanged: (value) {
                    tournamentState.selectNumberOfGroup(value!);
                  },
                  width: 270.w,
                  value: tournamentState.selectedNumberOfGroup,
                  items: tournamentState.numberOfGroup,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
