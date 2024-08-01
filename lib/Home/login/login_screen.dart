import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Home/register/register_screen.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/theme_and_color/color_app.dart';

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
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        themeProvider.theme == ThemeMode.light
            ? Image.asset(
                "assets/images/login.png",
                height: height,
                width: width,
                fit: BoxFit.fill,
              )
            : Image.asset(
                "assets/images/SIGN IN – 1.png",
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
                      return AppLocalizations.of(context)!.please_enter_email;
                    }
                    return null;
                  },
                  controller: email,
                  lableText: AppLocalizations.of(context)!.email,
                ),
                Textfieldcustom(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_password;
                    }
                    return null;
                  },
                  controller: password,
                  lableText: AppLocalizations.of(context)!.password,
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
    DailogUtils.showLoading(
      context,
      themeProvider.theme == ThemeMode.light
          ? ColorApp.whiteColor
          : ColorApp.itemsDarkColor,
    );

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(context)!.login_successfully,
          button1Name: AppLocalizations.of(context)!.ok,
          button1Function: () {
            Navigator.pushReplacementNamed(context, Home.routeName);
          });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.itemsDarkColor,
            context: context,
            title: AppLocalizations.of(context)!.faild,
            content: AppLocalizations.of(context)!.email_or_password_wrong,
            button1Name: AppLocalizations.of(context)!.ok);
      } else if (e.code == 'network-request-failed') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.faild,
          content: AppLocalizations.of(context)!.network_request_failed,
          button1Name: AppLocalizations.of(context)!.ok,
        );
      }
    } catch (e) {
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.faild,
          content: AppLocalizations.of(context)!
              .someting_went_wrong_pealse_try_again,
          button1Name: AppLocalizations.of(context)!.ok);
    }
  }
}
