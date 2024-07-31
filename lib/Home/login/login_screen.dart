import 'package:flutter/material.dart';

import '../../widgets_and_functions/TextFieldCustom.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Textfieldcustom(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              controller: email,
              lableText: "email",
            ),
            Textfieldcustom(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              controller: password,
              lableText: "password",
            ),
          ],
        ),
      ),
    );
  }
}
