import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/common_drop_down.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class MatchDurationWidget extends StatelessWidget {
  final TournamentProvider tournamentState;
  const MatchDurationWidget({super.key, required this.tournamentState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonContainer(
            onTap: () async {},
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
                  Row(
                    children: [
                      CommonDropDown(
                        height: 35.h,
                        width: 100.w,
                        style: subHeadingStyle.copyWith(
                          fontSize: 12.sp,
                          color: TColor.greyText,
                        ),
                        value: tournamentState.gameTime,
                        onchanged: (value) {
                          tournamentState.selectGameTime(value!);
                        },
                        items: tournamentState.gameTimeList,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CommonContainer(
            onTap: () async {},
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
                    tournamentState.firstHalf,
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
