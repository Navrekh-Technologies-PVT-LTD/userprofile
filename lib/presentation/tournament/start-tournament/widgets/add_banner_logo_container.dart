import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoursportz/gen/assets.gen.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/text_styles.dart';

class AddBannerLogoContainer extends StatelessWidget {
  final TournamentProvider tournamentState;
  final bool isEdit;
  const AddBannerLogoContainer(
      {super.key, required this.tournamentState, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Stack(
        children: [
          CommonContainer(
            onTap: () {
              isEdit ? null : tournamentState.getImage();
            },
            height: 160.h,
            width: MediaQuery.sizeOf(context).width,
            color: const Color(0xffD3D3D3),
            border: Border.all(
              color: const Color(0xff7A7A7A),
              width: 0.33.sp,
            ),
            borderRadius: BorderRadius.circular(10.r),
            child: tournamentState.imagePath == "null"
                ? Column(
                    children: [
                      const Spacer(),
                      SizedBox(height: 40.h),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF575757),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Add\nBanner ",
                        style: subHeadingStyle.copyWith(
                          color: const Color(0xff575757),
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CommonContainer(
                            height: 20.h,
                            width: 20.w,
                            color: Colors.white,
                            boxShape: BoxShape.circle,
                            child: Icon(
                              Icons.camera_alt,
                              color: const Color(0xFF575757),
                              size: 14.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: isEdit
                        ? Image.network(
                            tournamentState.imagePath,
                            height: 160.h,
                            width: MediaQuery.sizeOf(context).width,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            tournamentState.imageFile,
                            height: 160.h,
                            width: MediaQuery.sizeOf(context).width,
                            fit: BoxFit.cover,
                          ),
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                CommonContainer(
                  height: 75.h,
                  width: 75.w,
                  onTap: () {
                    isEdit ? null : tournamentState.getBannerImage();
                  },
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xff7A7A7A),
                    width: 0.33.sp,
                  ),
                  boxShape: BoxShape.circle,
                  child: tournamentState.bannerImagePath == "null"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.images.trophyIcon),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Add Logo",
                              style: subHeadingStyle.copyWith(
                                fontSize: 10.sp,
                                color: const Color(0xff575757),
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: isEdit
                              ? Image.network(
                                  tournamentState.bannerImagePath,
                                  height: 75.h,
                                  width: 75.w,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  tournamentState.bannerImageFile,
                                  height: 75.h,
                                  width: 75.w,
                                  fit: BoxFit.cover,
                                ),
                        ),
                ),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: CommonContainer(
                    height: 20.h,
                    width: 20.w,
                    color: Colors.white,
                    boxShape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff7A7A7A),
                      width: 0.33.sp,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: const Color(0xFF575757),
                      size: 14.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
