import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Home/register/cubit/register_states.dart';
import 'package:to_do_app/Home/register/cubit/register_view_model.dart';
import 'package:to_do_app/Home/register/test.dart';
import 'package:to_do_app/data/api_manger.dart';
import 'package:to_do_app/di/di.dart';
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
  RegisterViewModel registerViewModel = getIt<RegisterViewModel>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    registerViewModel.userName.dispose();
    registerViewModel.password.dispose();
    registerViewModel.email.dispose();
    registerViewModel.rPassword.dispose();
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
        BlocProvider<RegisterViewModel>(
          create: (context) => registerViewModel,
          child: BlocListener<RegisterViewModel, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterStateSuccess) {
                DailogUtils.hideLoading(context);
                DailogUtils.showMessage(
                    context: context,
                    color: Colors.white,
                    content: "Register Successfully",
                    title: "Success",
                    button1Name: "ok"
                );
              }else if (state is RegisterStateError) {
                DailogUtils.hideLoading(context);
                DailogUtils.showMessage(
                    context: context,
                    color: Colors.white,
                    content: state.failures.errorMessage,
                    title: "Error",
                  button1Name: "ok"
                );
              }else{
                DailogUtils.showLoading(context, Colors.white);

              }
            },
            child: Scaffold(
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
                        controller: registerViewModel.userName,
                        lableText: AppLocalizations.of(context)!.user,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_your_email;
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);

                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .enter_valid_email;
                          }
                          return null;
                        },
                        controller: registerViewModel.email,
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
                        controller: registerViewModel.password,
                        lableText: AppLocalizations.of(context)!.password,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_confirm_password;
                          }
                          if (text != registerViewModel.password.text) {
                            return AppLocalizations.of(context)!
                                .password_dont_match;
                          }
                          return null;
                        },
                        controller: registerViewModel.rPassword,
                        lableText:
                            AppLocalizations.of(context)!.confirm_password,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter phone please:";
                          }
                          if(text.length != 11){
                            return "enter 11 digits Please";
                          }
                          return null;
                        },
                        controller: registerViewModel.phone,
                        lableText: "enter phone",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                registerViewModel.register();


                              }
                            },
                            child:
                                Text(AppLocalizations.of(context)!.register)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
