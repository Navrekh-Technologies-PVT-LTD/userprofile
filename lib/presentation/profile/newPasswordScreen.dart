import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../gen/locale_keys.g.dart';


class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool _isObscure = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _continueAction() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      // Show an error message if any field is empty
      // Handle accordingly
      return;
    }

    if (password != confirmPassword) {
      // Passwords don't match, show an error message
      // Handle accordingly
      return;
    }

    // Passwords match, proceed with your logic here
    // MyRouter.pushPage(context, NextScreen());
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(tr(LocaleKeys.enter_new_password),
                    //'Enter new password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 24),
                  Text(tr(LocaleKeys.password),
                    //'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text( tr(LocaleKeys.confirm_password),
                   // 'Confirm Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: _isObscure,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    tr(LocaleKeys.password_requirements),
                    //'Your password must contain at least 8 characters with capital letters and numbers',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for verification here
                    // MyRouter.pushPage(context, EmailVerificationPage());
                    //MyRouter.pushPageReplacement(context, SignInPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.red.shade50,
                  ),
                  child: Text(tr(LocaleKeys.continue_btn)),
                    //'CONTINUE'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
