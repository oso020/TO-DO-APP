import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Home/login/login_screen.dart';
import 'package:to_do_app/Home/settings/settings_tab.dart';
import 'package:to_do_app/Home/to_do_list/to_do_list_tab.dart';
import 'package:to_do_app/Home/widgets/modal_sheet_add_task.dart';
import 'package:to_do_app/providers/user_auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/getTaskProvider.dart';
import '../providers/theme_provider.dart';
import '../theme_and_color/color_app.dart';
import '../widgets_and_functions/dialog_model.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var authProvider = Provider.of<AuthUserProvider>(context);
    var getTaskProvider = Provider.of<GetTaskProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height / 10,
        title: Text(
          "${AppLocalizations.of(context)!.to_do_list} \n ${AppLocalizations.of(context)!.user}: ${authProvider.currentUser!.userName!} ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                DailogUtils.showMessage(
                    color: themeProvider.theme == ThemeMode.light
                        ? ColorApp.whiteColor
                        : ColorApp.itemsDarkColor,
                    title: AppLocalizations.of(context)!.are_you_sure,
                    content: AppLocalizations.of(context)!.logout,
                    context: context,
                    button2Name: AppLocalizations.of(context)!.yes,
                    button2Function: () async {
                      getTaskProvider.tasks = [];
                      authProvider.currentUser = null;
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    button1Name: AppLocalizations.of(context)!.no,
                    barrierDismissible: true);
              },
              icon: Icon(Icons.logout))
        ],
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: height / 12,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: (index) {
            selectIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: AppLocalizations.of(context)!.to_do_list,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 26,
              ),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalSheetAddTask();
        },
        child: const Icon(Icons.add, color: ColorApp.whiteColor),
      ),
      body: widgets[selectIndex],
    );
  }

  List<Widget> widgets = [ToDOListTap(), const Settings()];

  void showModalSheetAddTask() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.black)),
        builder: (context) => ModalSheetAddTask());
  }
}
