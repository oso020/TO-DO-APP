import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/Home/settings/settings_tab.dart';
import 'package:to_do_app/Home/to_do_list/to_do_list_tab.dart';
import 'package:to_do_app/Home/widgets/modal_sheet_add_task.dart';

import '../color_app.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.to_do_list,
          style: Theme.of(context).textTheme.titleMedium,
        ),
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

  List<Widget> widgets = [const ToDOListTap(), const Settings()];

  void showModalSheetAddTask() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.black)),
        builder: (context) => ModalSheetAddTask());
  }
}
