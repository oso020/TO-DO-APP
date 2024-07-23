import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/color_app.dart';

import '../../providers/theme_provider.dart';

class ChangeDetilesTaskScreen extends StatefulWidget {
  static const String routeName = "changeDetiles";

  ChangeDetilesTaskScreen({super.key});

  @override
  State<ChangeDetilesTaskScreen> createState() =>
      _ChangeDetilesTaskScreenState();
}

class _ChangeDetilesTaskScreenState extends State<ChangeDetilesTaskScreen> {
  final form = GlobalKey<FormState>();

  var selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.to_do_list,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: ColorApp.primaryColor,
            width: double.infinity,
            height: height / 3,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: height / 10, horizontal: width / 50),
            padding: const EdgeInsets.all(10),
            height: height / 1.5,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themeProvider.theme == ThemeMode.light
                  ? ColorApp.whiteColor
                  : ColorApp.itemsDarkColor,
            ),
            child: Form(
              key: form,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      textAlign: TextAlign.center,
                      style: themeProvider.theme == ThemeMode.light
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorApp.whiteColor, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: (String? text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_tilte;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 12),
                                hintText:
                                    AppLocalizations.of(context)!.change_title,
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          TextFormField(
                            validator: (String? text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_description;
                              }
                              return null;
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 12),
                                hintText: AppLocalizations.of(context)!
                                    .change_Description,
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          InkWell(
                            onTap: () {
                              openDateSheet();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.select_time,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: ColorApp.grayColor),
                            ),
                          ),
                          SizedBox(
                            height: height / 200,
                          ),
                          Text(
                            "${selectDate.day}/${selectDate.month}/${selectDate.year}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {}
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save_changes,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorApp.whiteColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void openDateSheet() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: ColorApp.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    selectDate = chosenDate ?? selectDate;
    setState(() {});
  }
}
