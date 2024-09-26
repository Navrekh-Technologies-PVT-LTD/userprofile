// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/providers/auth/auth_provider.dart';
import 'package:yoursportz/providers/common/common_provider.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/logger.dart';
import 'package:yoursportz/utils/toast.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = TextEditingController();
  String selectedCountryCode = '+91';
  var valid = true;
  var validNumber = false;
  var isLoading = false;
  final otplessFlutterPlugin = Otpless();
  var providedCountryCode = "";
  var providedPhoneNumber = "";
  var socialLoginLoading = false;
  Map<String, dynamic> completeResponse = {};
  bool guestlogin = false;

  void initiateOtpless() {
    otplessFlutterPlugin.initHeadless("H6NVDI88B5QUHH6UG60Z");
    otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
  }

  void sentOtpRequest(BuildContext context) async {
    if (controller.text.length < 10) {
      setState(() {
        valid = false;
      });
    } else {
      setState(() {
        isLoading = true;
        providedCountryCode = selectedCountryCode;
        providedPhoneNumber = controller.text;
      });
      await startHeadlessPhone(
        selectedCountryCode,
        controller.text,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        AutoRouter.of(context).push(
          OtpRoute(
            countryCode: providedCountryCode,
            phone: providedPhoneNumber,
          ),
        );
      }
    }
  }

  bool navigateToUserDetails = false;
  bool navigateToAppBase = false;
  String phoneNumber = '';

  Future<void> onHeadlessResult(dynamic result) async {
    logger.i("Otpless Result : $result");
    if (result['response']['channel'] == "PHONE") {
      setState(() {
        isLoading = false;
      });
    } else {
      if (result['responseType'] == "ONETAP") {
        if (result['statusCode'] == 200) {
          setState(() {
            socialLoginLoading = true;
          });

          final userID = result['response']['identities'][0]['identityValue'];
          await getIt<AppPrefs>().phoneNumber.setValue(userID);
          final body = jsonEncode(<String, dynamic>{'userId': userID});
          final response = await http.post(
              Uri.parse(
                  "https://yoursportzbackend.azurewebsites.net/api/auth/check-user/"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: body);
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['message'] == "success") {
            socialLoginLoading = false;

            setState(() {
              phoneNumber = userID;
            });
            AutoRouter.of(context).push(
              UserDetailsRoute(
                language: getIt<AppPrefs>().language.getValue(),
                phone: phoneNumber,
              ),
            );
          } else {
            socialLoginLoading = false;

            setState(() {
              phoneNumber = userID;
            });
            AutoRouter.of(context).push(AppBaseRoute(phone: phoneNumber));
          }
        } else {
          showToast(LocaleKeys.auth_failed.tr(), Colors.red);
        }
      }
    }
  }

  Future<void> startHeadless(String channelType) async {
    Map<String, dynamic> arg = {'channelType': channelType};
    await otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  Future<void> startHeadlessPhone(
      String countryCode, String phoneNumber) async {
    Map<String, dynamic> arg = {};
    arg["phone"] = phoneNumber;
    arg["countryCode"] = countryCode;
    await otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initiateOtpless();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommonProvider, AuthenticationProvider>(
      builder: (context, commonState, authState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/app_icon.png', height: 50),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.your.tr(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff554585),
                            ),
                          ),
                          Text(
                            LocaleKeys.sportz.tr(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        LocaleKeys.game_it_your_way.tr(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 48),
                      TextField(
                          controller: controller,
                          onChanged: (String value) {
                            setState(() {
                              if (value.length == 10) {
                                setState(() {
                                  validNumber = true;
                                  valid = true;
                                });
                              } else {
                                setState(() {
                                  validNumber = false;
                                });
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 240, 240, 245),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: DropdownButton<String>(
                                    underline: Container(height: 0),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    value: selectedCountryCode,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCountryCode = newValue!;
                                      });
                                    },
                                    items: commonState.countryCodes
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              hintText: LocaleKeys.enter_your_phone_number.tr(),
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                              errorText: valid
                                  ? null
                                  : LocaleKeys.cant_be_less_than_10_digits.tr(),
                              errorStyle: const TextStyle(
                                backgroundColor: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: validNumber
                                  ? const Icon(
                                      Icons.check_box_rounded,
                                      color: Colors.green,
                                    )
                                  : null)),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                sentOtpRequest(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  backgroundColor: const Color(0xff554585)),
                              child: isLoading
                                  ? Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        LocaleKeys.sign_in.tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.or.tr(),
                          style: TextStyle(fontSize: 17.sp, color: Colors.grey),
                        ),
                      ),
                      socialLoginLoading
                          ? const Padding(
                              padding: EdgeInsets.all(3),
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await startHeadless("WHATSAPP");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20.w,
                                      backgroundColor: Colors.transparent,
                                      child: ClipOval(
                                        child: Image.asset(
                                            'assets/images/whatsapp_icon.png',
                                            height: 70.h),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    startHeadless("GMAIL");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: Colors.transparent,
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/google_icon.png',
                                          height: 70.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    startHeadless("FACEBOOK");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: Colors.transparent,
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/facebook_icon.png',
                                          height: 70.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (Platform.isIOS)
                                  GestureDetector(
                                    onTap: () {
                                      startHeadless("APPLE");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.w,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/apple_icon.png',
                                            height: 70.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: () {
                                    startHeadless("TWITTER");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: Colors.transparent,
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/x_icon.png',
                                          height: 70.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 50.h),
                      ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context).pushAndPopUntil(
                            AppBaseRoute(phone: "guest"),
                            predicate: (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            backgroundColor: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            LocaleKeys.sign_in_as_guest.tr(),
                            style: const TextStyle(
                              color: Color(0xff554585),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
