import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/Home/register/register_screen.dart';

import '../../widgets_and_functions/TextFieldCustom.dart';
import '../../widgets_and_functions/dialog_model.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_screen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController(text: "osman@gmail.com");

  TextEditingController password = TextEditingController(text: "Mm#123456");

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
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            centerTitle: true,
          ),
          body: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          loginFirebaseAuth();
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.login)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  loginFirebaseAuth() async {
    DailogUtils.showLoading(context);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      print('Success');

      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
          context: context,
          title: "Success",
          content: "Login Successfully",
          button1Name: "Ok",
          button1Function: () {
            Navigator.pushReplacementNamed(context, Home.routeName);
          });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
            context: context,
            title: "Faild",
            content: "Email or Password Wrong",
            button1Name: "Ok");
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
          content: e.toString(),
          button1Name: "Ok");
    }
  }
}
