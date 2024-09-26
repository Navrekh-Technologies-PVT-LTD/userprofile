import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/utils/color.dart';

import '../../gen/locale_keys.g.dart';
import '../../utils/size_config.dart';
import 'otherInfoScreen.dart';
import 'sign_in_screen.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool agree = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                tr(LocaleKeys.yscreate_your_account),
                //"Create your YourSportz account",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 23),
                maxLines: 2,
              ),
            ),
          ],
        ),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenH,
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                tr(LocaleKeys.name),
                //'Name',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr(LocaleKeys.provide_full_name),
                //'Please provide your full name',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 20),
              // Email Field
              Text(
                tr(LocaleKeys.emailadd),
                //'Email Address',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr(LocaleKeys.provide_valid_email),
                //'Please provide a valid email address',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 20),
              // Password Field
              Text(
                tr(LocaleKeys.password),
                //'Password',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr(LocaleKeys.password_requirements),
                //'Your password must contain at least 8 characters with capital letters and numbers',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 40),
              // Next Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtherInfoScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Checkbox(
                    value: agree // Provide the value of the checkbox,
                    // Provide the onChanged callback for the checkbox,
                    ,
                    onChanged: (bool? value) {
                      setState(() {
                        agree = true;
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
                            // 'Terms & Conditions',
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
                            // ' of YourSoprtz.',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      tr(LocaleKeys.or),
                      //'Or',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
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
                    // 'Already have an Account? ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 13), // Color for the first part of the text
                    children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.sign_in),
                        //'Sign in',
                        style: const TextStyle(
                            color: Color(0xff007AFF)), // Color for "Sign in"
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr(LocaleKeys.skip_for_now),
                    //"Skip for now",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
