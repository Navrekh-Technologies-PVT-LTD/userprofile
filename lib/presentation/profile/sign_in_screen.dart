import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/utils/color.dart';

import '../../gen/locale_keys.g.dart';
import '../../utils/size_config.dart';
import 'forgetPassworScreen.dart';
import 'sign_up_creen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 0,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                tr(LocaleKeys.sign_in_email),
                //'Sign in with your email',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          leading: Container()),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        height: SizeConfig.screenH,
        width: SizeConfig.screenW,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(LocaleKeys.email),
                    //'Email ',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: tr(LocaleKeys.enter_email_address),
                        //'Enter your email address',
                        labelStyle: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 12),
                  // Password Field
                  Text(
                    tr(LocaleKeys.password),
                    //'Password',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: tr(LocaleKeys.enter_password),
                      //'Enter the password',
                      labelStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 10),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Sign In Button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                      // MyRouter.pushPage(context, ForgotPasswordPage());
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red),
                    ),
                  ),

                  const SizedBox(height: 150),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      tr(LocaleKeys.sign_in),
                      //'Sign In',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 36),
                ],
              ),
              Container(
                height: 120,
              ),
              TextButton(
                onPressed: () {
                  // Handle sign-in navigation
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                  //MyRouter.pushPage(context, SignInPage());
                },
                child: Text.rich(
                  TextSpan(
                    text: tr(LocaleKeys.create_new_account),
                    //'Create new account? ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(
                            0.5)), // Color for the first part of the text
                    children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.sign_up),
                        //'Sign Up',
                        style: const TextStyle(
                            color: Color(0xff007AFF)), // Color for "Sign in"
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
