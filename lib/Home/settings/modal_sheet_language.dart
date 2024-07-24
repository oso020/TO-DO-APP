import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/language_provider.dart';

import '../../theme_and_color/color_app.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          InkWell(
              onTap: () {
                provider.changeLanguage("en");
              },
              child: provider.locale == "en"
                  ? selectedWidget(AppLocalizations.of(context)!.english)
                  : unSelectedWidget(AppLocalizations.of(context)!.english)),
          InkWell(
              onTap: () {
                provider.changeLanguage("ar");
              },
              child: provider.locale == "ar"
                  ? selectedWidget(AppLocalizations.of(context)!.arabic)
                  : unSelectedWidget(AppLocalizations.of(context)!.arabic))
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
