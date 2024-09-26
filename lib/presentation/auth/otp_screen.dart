import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/presentation/auth/login_screen.dart';
import 'package:yoursportz/routing/app_router.gr.dart';

@RoutePage()
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.countryCode, required this.phone});

  final String countryCode;
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int secondsRemaining = 60;
  late Timer timer;
  var isLoading = false;
  var validOTP = true;
  final otp1 = TextEditingController();
  final otp2 = TextEditingController();
  final otp3 = TextEditingController();
  final otp4 = TextEditingController();
  final otp5 = TextEditingController();
  final otp6 = TextEditingController();
  var focusNode1 = FocusNode();
  var focusNode2 = FocusNode();
  var focusNode3 = FocusNode();
  var focusNode4 = FocusNode();
  var focusNode5 = FocusNode();
  var focusNode6 = FocusNode();
  final otplessFlutterPlugin = Otpless();
  late String completePhoneNumer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> onHeadlessResult(dynamic result) async {
    if (result['responseType'] == "ONETAP") {
      if (result['statusCode'] == 200) {
        completePhoneNumer =
            widget.countryCode.replaceAll("+", "") + widget.phone;
        getIt<AppPrefs>().phoneNumber.setValue(completePhoneNumer);
        final body = jsonEncode(<String, dynamic>{
          'userId': completePhoneNumer,
        });
        final response = await http.post(
            Uri.parse(
                "https://yoursportzbackend.azurewebsites.net/api/auth/check-user/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body);

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['message'] == "success") {
          if (mounted) {
            AutoRouter.of(context).pushAndPopUntil(
              UserDetailsRoute(
                  language: getIt<AppPrefs>().language.getValue(),
                  phone: completePhoneNumer),
              predicate: (route) => false,
            );
          }
        } else {
          if (mounted) {
            showDialog(
              context: context,
              builder: ((context) => Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.cyan,
                              size: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                LocaleKeys.verified.tr(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          }
          setState(() {
            isLoading = false;
          });
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            AutoRouter.of(context).pushAndPopUntil(
              AppBaseRoute(phone: completePhoneNumer),
              predicate: (route) => false,
            );
          }
        }
      }
    } else if (result['response']['verification'] == "FAILED") {
      setState(() {
        validOTP = false;
        isLoading = false;
      });
    }
  }

  Future<void> startHeadlessPhoneVerify(
      String countryCode, String phoneNumber, String otp) async {
    Map<String, dynamic> arg = {};
    arg["phone"] = phoneNumber;
    arg["countryCode"] = countryCode;
    arg["otp"] = otp;
    otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.enter_otp.tr(),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: Text(
                  LocaleKeys.otp_has_been_sent_to.tr(args: [widget.phone]),
                  style: const TextStyle(color: Colors.grey, fontSize: 15)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 20),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode2.nextFocus();
                      }
                    },
                    controller: otp1,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode1,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode3.nextFocus();
                      }
                    },
                    controller: otp2,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode2,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode4.nextFocus();
                      }
                    },
                    controller: otp3,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode3,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode5.nextFocus();
                      }
                    },
                    controller: otp4,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode4,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode6.nextFocus();
                      }
                    },
                    controller: otp5,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode5,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        focusNode6.unfocus();
                      }
                    },
                    controller: otp6,
                    keyboardType: TextInputType.number,
                    focusNode: focusNode6,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 245),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 32, 8),
              child: Row(
                children: [
                  validOTP
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                          child: Text(
                            LocaleKeys.invalid_otp.tr(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                  const Spacer(),
                  Text(
                    formatDuration(Duration(seconds: secondsRemaining)),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            ),
            Center(child: Text(LocaleKeys.didnt_received_otp_resend_otp.tr())),
            GestureDetector(
              onTap: () async {
                if (secondsRemaining == 0) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const LoginScreen()),
                    ),
                  );
                }
              },
              child: Center(
                child: Text(
                  LocaleKeys.resend_otp.tr(),
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                      color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () async {
                      if (secondsRemaining != 0) {
                        setState(() {
                          validOTP = true;
                          isLoading = true;
                        });
                        final otp = otp1.text +
                            otp2.text +
                            otp3.text +
                            otp4.text +
                            otp5.text +
                            otp6.text;
                        startHeadlessPhoneVerify(
                            widget.countryCode, widget.phone, otp);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(LocaleKeys.otp_expired.tr(),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xff554585)),
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(4),
                            child: Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(
                                  color: Colors.white),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(LocaleKeys.verify.tr(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
