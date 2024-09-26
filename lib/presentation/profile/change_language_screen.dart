import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

@RoutePage()
class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  // List of languages
  final List<String> languages = [
    'عربي',
    'Brasileiro',
    'English',
    'Français',
    'हिंदी',
    'Português',
    'Español',
    'اردو'
  ];

  // Variable to store the selected language
  String selectedLanguage = 'English';
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
                      "Change Language",
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
                height: 653.h,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.which_language_do_you_speak.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(
                        languages.length,
                        (index) {
                          return RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(languages[index]),
                            value: languages[index],
                            groupValue: selectedLanguage,
                            onChanged: (value) async {
                              setState(() {
                                selectedLanguage = value!;
                              });

                              getIt<AppPrefs>().language.setValue(value!);
                              if (value == "عربي") {
                                await context.setLocale(const Locale('ar'));
                              } else if (value == "Brasileiro") {
                                await context
                                    .setLocale(const Locale('pt', 'BR'));
                              } else if (value == "English") {
                                await context.setLocale(const Locale('en'));
                              } else if (value == "Français") {
                                await context.setLocale(const Locale('fr'));
                              } else if (value == "हिंदी") {
                                await context.setLocale(const Locale('hi'));
                              } else if (value == "Português") {
                                await context.setLocale(const Locale('pt'));
                              } else if (value == "Español") {
                                await context.setLocale(const Locale('es'));
                              } else if (value == "اردو") {
                                await context.setLocale(const Locale('ur'));
                              }
                            },
                          );
                        },
                      ),
                      const Spacer(),
                      CommonContainer(
                        onTap: () {
                          context.popBack();
                        },
                        height: 35.h,
                        width: MediaQuery.sizeOf(context).width,
                        color: const Color(0xff554585),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Center(
                          child: Text(
                            "Save",
                            style: subHeadingStyle.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
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
