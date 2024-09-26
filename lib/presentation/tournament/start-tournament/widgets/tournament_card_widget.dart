import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/gen/assets.gen.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/presentation/tournament/standings.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class TournamentCardWidget extends StatelessWidget {
  final TournamentData data;
  const TournamentCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      height: 209.h,
      width: MediaQuery.sizeOf(context).width,
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => Standings(
                  tournamentData: data,
                  phone: getIt<AppPrefs>().phoneNumber.getValue(),
                )),
          ),
        );
      },
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 5.0,
          spreadRadius: 2,
          offset: const Offset(0.0, 0.75),
        )
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonContainer(
            height: 148.h,
            width: MediaQuery.sizeOf(context).width,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            image: DecorationImage(
              image: AssetImage(Assets.images.bannerTournament.path),
              fit: BoxFit.cover,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.tournamentName!,
                    style: headingStyle.copyWith(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data.city!,
                    style: subHeadingStyle.copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.startDate} ${data.endDate == "null" ? "" : "to"} ${data.endDate == "null" ? "" : data.endDate}",
                        style: subHeadingStyle.copyWith(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                      CommonContainer(
                        height: 25.h,
                        width: 66.w,
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white.withOpacity(0.53),
                        border: Border.all(
                          color: TColor.borderColor,
                          width: 0.33.w,
                        ),
                        child: Center(
                          child: Text(
                            data.status![0].toUpperCase() +
                                data.status!.substring(1),
                            style: subHeadingStyle.copyWith(
                              fontSize: 10.h,
                              color: TColor.greyText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.organizerName!,
                  style: headingStyle.copyWith(
                    color: TColor.greyText,
                    fontSize: 16.sp,
                  ),
                ),
                CommonContainer(
                  height: 27.h,
                  width: 72.w,
                  onTap: () async {
                    // await fetchTournamentChatId(tournament['tournamentId']);
                    // if (tournamentChatId != null) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChatScreen(
                    //               teamName: tournament['tournamentName'],
                    //               teamLogo: '',
                    //               chatId: tournamentChatId!,
                    //               phone: phone,
                    //             )),
                    //   );
                    // } else {
                    //   // Handle the case where chatId is still null
                    //   print('Error: chatId is null');
                    // }
                  },
                  color: const Color(0xff554585),
                  borderRadius: BorderRadius.circular(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/chatIcon.svg',
                        height: 14.h,
                        width: 16.w,
                      ),
                      const Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
