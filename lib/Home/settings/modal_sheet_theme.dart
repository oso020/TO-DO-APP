import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../color_app.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';

class ModalSheetTheme extends StatefulWidget {
  const ModalSheetTheme({super.key});

  @override
  State<ModalSheetTheme> createState() => _ModalSheetThemeState();
}

class _ModalSheetThemeState extends State<ModalSheetTheme> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          InkWell(
              onTap: () {
                themeProvider.changeTheme(ThemeMode.light);
              },
              child: themeProvider.theme == ThemeMode.light
                  ? selectedWidget(AppLocalizations.of(context)!.light)
                  : unSelectedWidget(AppLocalizations.of(context)!.light)),
          InkWell(
              onTap: () {
                themeProvider.changeTheme(ThemeMode.dark);
              },
              child: themeProvider.theme == ThemeMode.dark
                  ? selectedWidget(AppLocalizations.of(context)!.dark)
                  : unSelectedWidget(AppLocalizations.of(context)!.dark))
        ],
      ),
    );
  }

  Widget selectedWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorApp.primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          size: 35,
        )
      ],
    );
  }

  Widget unSelectedWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorApp.blackColor),
        ),
      ],
    );
  }
}
