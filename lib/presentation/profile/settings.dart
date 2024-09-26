// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/gen/assets.gen.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.phone});

  final String phone;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonContainer(
              height: 81.h,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 10.0,
                  spreadRadius: 2,
                  offset: const Offset(0.0, 0.75),
                )
              ],
              child: Padding(
                padding: EdgeInsets.only(left: 21.w, bottom: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        context.popBack();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: TColor.greyText,
                      ),
                    ),
                    SizedBox(width: 7.25.w),
                    Text(
                      "Settings",
                      style: subHeadingStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonContainer(
                height: 150.h,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          context.navigateTo(const ChangeLanguageRoute());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(Assets.images.changeLangIcon),
                            SizedBox(width: 8.w),
                            Text(
                              "Change Language",
                              style: headingStyle.copyWith(
                                fontSize: 12.sp,
                                color: TColor.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: SingleChildScrollView(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child:
                                      Text(LocaleKeys.feature_unavailable.tr()),
                                )),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(Assets.images.deleteIcon),
                            SizedBox(width: 8.w),
                            Text(
                              "Delete Account",
                              style: headingStyle.copyWith(
                                fontSize: 12.sp,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var currentUser = await Hive.openBox('CurrentUser');
                          await currentUser.put('userId', 'null');
                          await getIt<AppPrefs>().phoneNumber.setValue('null');
                          AutoRouter.of(context).pushAndPopUntil(
                            const LoginRoute(),
                            predicate: (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Row(
                                  children: [
                                    Text(
                                      LocaleKeys.user_successfully_logged_out
                                          .tr(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.done_all,
                                        color: Colors.white)
                                  ],
                                ),
                                backgroundColor: Colors.green),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(Assets.images.logoutIcon),
                            SizedBox(width: 8.w),
                            Text(
                              "Logout",
                              style: headingStyle.copyWith(
                                fontSize: 12.sp,
                                color: TColor.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
