import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/utils/color.dart';

import '../../gen/locale_keys.g.dart';
import '../../utils/size_config.dart';

// import 'emailVerificationScreen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              tr(LocaleKeys.forgot_ur_password),
              // "Forgot your password",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        leading: Container(),
      ),
      body: Container(
        height: SizeConfig.screenH,
        width: SizeConfig.screenW,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 14),
                  const Text(
                    'Your Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: tr(LocaleKeys.enter_email_address),
                        //'Enter your email address',
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                        )),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tr(LocaleKeys.enter_email_associated),
                    //'Enter the email address associated with your account',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: tr(LocaleKeys.remember_password),
                        //'Remember your password? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                            fontSize:
                                12), // Color for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleKeys.sign_in.tr(),
                            style: const TextStyle(
                                color:
                                    Color(0xff007AFF)), // Color for "Sign in"
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'Get Code',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
