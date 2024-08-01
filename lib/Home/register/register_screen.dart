import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Home/login/login_screen.dart';
import 'package:to_do_app/widgets_and_functions/dialog_model.dart';

import '../../widgets_and_functions/TextFieldCustom.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName = TextEditingController(text: "mohamed");

  TextEditingController email = TextEditingController(text: "osman@gmail.com");

  TextEditingController password = TextEditingController(text: "Mm#123456");

  TextEditingController confiramPassword =
      TextEditingController(text: "Mm#123456");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userName.dispose();
    password.dispose();
    email.dispose();
    confiramPassword.dispose();
  }

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Image.asset(
          "assets/images/login.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Create Account",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            centerTitle: true,
          ),
          body: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: height / 4,
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
                    lableText: "password",
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
                    lableText: "confirmpassword",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            registerFirebaseAuth();
                          }
                        },
                        child: Text("regisiter")),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  registerFirebaseAuth() async {
    DailogUtils.showLoading(context);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
          context: context,
          title: "Success",
          content: "Created Successfully",
          button1Name: "Ok",
          button1Function: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          context: context,
          title: "Faild",
          content: "Email or Password Wrong",
          button1Name: "Ok",
        );
      } else if (e.code == 'email-already-in-use') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          context: context,
          title: "Faild",
          content: "email-already-in-use",
          button1Name: "Ok",
        );
      } else if (e.code == 'network-request-failed') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          context: context,
          title: "Faild",
          content: "network-request-failed",
          button1Name: "Ok",
        );
      }
    } catch (e) {
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
        context: context,
        title: "Faild",
        content: "Someting Went Wrong Please try again",
        button1Name: "Ok",
      );
    }
  }
}
