import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/utils/color.dart';

import '../../core/pref_data.dart';
import '../../gen/locale_keys.g.dart';
import '../../utils/size_config.dart';
import 'createAccountScreen.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agree = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferenceHelper().addBoolToSF("isFirtTime", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  tr(LocaleKeys.sign_up),
                  //"Sign Up",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                //TODO: add funcatioms
                //MyRouter.pushPage(context, BottomNave());
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        leading: Container(),
      ),
      body: Container(
        height: SizeConfig.screenH,
        width: SizeConfig.screenW,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    "assets/images/app_icon.png",
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Default color for the text
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: tr(LocaleKeys.your),
                          //'Your', // First part of the text
                          style: const TextStyle(
                              color: kPrimaryColor), // Color for this part
                        ),
                        TextSpan(
                          text: tr(LocaleKeys.sportz),
                          //'Sportz',
                          style: const TextStyle(color: Color(0xffFF5033)),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    tr(LocaleKeys.game_it_your_way),
                    //'Game it your way',
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Google sign-in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF2F2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded border
                        side: const BorderSide(
                            color: Colors.grey), // Border color
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ic_google.png",
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tr(LocaleKeys.continue_google),
                          //'Continue with Google     ',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Facebook sign-in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF2F2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded border
                        side: const BorderSide(
                            color: Colors.grey), // Border color
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace with your icon for Facebook
                        Image.asset(
                          "assets/images/ic_facebook.png",
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tr(LocaleKeys.continue_facebook),
                          //'Continue with Facebook',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Facebook sign-in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF2F2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded border
                        side: const BorderSide(
                            color: Colors.grey), // Border color
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace with your icon for Facebook
                        Image.asset(
                          "assets/images/ic_twitter.png",
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tr(LocaleKeys.continue_facebook),
                          //'Continue with Twitter',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccountPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        tr(LocaleKeys.create_account),
                        // 'Create Account',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle sign-in navigation
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                      //MyRouter.pushPage(context, SignInPage());
                    },
                    child: Text.rich(
                      TextSpan(
                        text: tr(LocaleKeys.already_have_account),
                        //'Already have an Account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(
                                0.5)), // Color for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: tr(LocaleKeys.sign_in),
                            //'Sign in',
                            style: const TextStyle(
                                color:
                                    Color(0xff007AFF)), // Color for "Sign in"
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: agree, // Provide the value of the checkbox
                      onChanged: (bool? value) {
                        setState(() {
                          agree = value ??
                              false; // Update the value based on user interaction
                        });
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: tr(LocaleKeys.agree_terms),
                              //'By registering you agree to the ',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: tr(LocaleKeys.terms_conditions),
                              //'Terms & Conditions',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xffFF0000),
                              ),
                            ),
                            const TextSpan(
                              text: ', ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: tr(LocaleKeys.privacy_policy),
                              //'Privacy Policy',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xffFF0000),
                              ),
                            ),
                            TextSpan(
                              text: tr(LocaleKeys.of_yoursportz),
                              //' of YourSoprtz.',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
