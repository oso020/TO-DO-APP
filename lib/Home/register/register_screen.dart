import 'package:flutter/material.dart';

import '../../widgets_and_functions/TextFieldCustom.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register_screen";

  RegisterScreen({super.key});

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confiramPassword = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height / 2.8,
                ),
                Textfieldcustom(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                  controller: userName,
                  lableText: "username",
                ),
                Textfieldcustom(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Please enter your email";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);

                    if (!emailValid) {
                      return "Enter valid email";
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

                    final bool regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(text);
                    if (!regex) {
                      return "Enter valid password";
                    }
                    return null;
                  },
                  controller: password,
                  lableText: "confirm password",
                ),
                Textfieldcustom(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Please enter your confirmPassword";
                    }
                    if (text != password.text) {
                      return "Confirm password dont match with password";
                    }
                    return null;
                  },
                  controller: confiramPassword,
                  lableText: "password",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {}
                      },
                      child: Text("regisiter")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
