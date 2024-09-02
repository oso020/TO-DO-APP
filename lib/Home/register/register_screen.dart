import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/theme_and_color/color_app.dart';
import 'package:to_do_app/widgets_and_functions/dialog_model.dart';

import '../../firebase_utils.dart';
import '../../providers/user_auth_provider.dart';
import '../../widgets_and_functions/TextFieldCustom.dart';
import '../home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confiramPassword = TextEditingController();
  bool isSecure = true;

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
              AppLocalizations.of(context)!.register,
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
                        return AppLocalizations.of(context)!
                            .enter_your_user_name;
                      }
                      return null;
                    },
                    controller: userName,
                    lableText: AppLocalizations.of(context)!.user,
                  ),
                  Textfieldcustom(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.enter_your_email;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);

                      if (!emailValid) {
                        return AppLocalizations.of(context)!.enter_valid_email;
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

                      final bool regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(text);
                      if (!regex) {
                        return AppLocalizations.of(context)!
                            .enter_valid_password;
                      }
                      return null;
                    },
                    controller: password,
                    obSecure: isSecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        isSecure = !isSecure;
                        setState(() {});
                      },
                      icon: isSecure == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    lableText: AppLocalizations.of(context)!.password,
                  ),
                  Textfieldcustom(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_confirm_password;
                      }
                      if (text != password.text) {
                        return AppLocalizations.of(context)!
                            .password_dont_match;
                      }
                      return null;
                    },
                    controller: confiramPassword,
                    lableText: AppLocalizations.of(context)!.confirm_password,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            registerFirebaseAuth();
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.register)),
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
    DailogUtils.showLoading(
      context,
      themeProvider.theme == ThemeMode.light
          ? ColorApp.whiteColor
          : ColorApp.itemsDarkColor,
    );
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      UserModel userData = UserModel(
          id: credential.user?.uid ?? '',
          email: email.text,
          userName: userName.text);

      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      authProvider.updateUser(userData);
      await FirebaseUtils.addUserFireStore(userData);
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(context)!.created_successfully,
          button1Name: AppLocalizations.of(context)!.ok,
          button1Function: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Home.routeName,
              (Route<dynamic> route) => false,
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.faild,
          content: AppLocalizations.of(context)!.email_or_password_wrong,
          button1Name: AppLocalizations.of(context)!.ok,
        );
      } else if (e.code == 'email-already-in-use') {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          context: context,
          title: AppLocalizations.of(context)!.faild,
          content: AppLocalizations.of(context)!.email_already_in_use,
          button1Name: AppLocalizations.of(context)!.ok,
        );
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
