import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/color_app.dart';
import 'package:to_do_app/providers/theme_provider.dart';

import 'change_detiles_task_screen.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChangeDetilesTaskScreen.routeName);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: themeProvider.theme == ThemeMode.light
                ? ColorApp.whiteColor
                : ColorApp.itemsDarkColor,
            borderRadius: BorderRadius.circular(22)),
        child: Row(
          children: [
            Container(
              height: height / 9,
              width: 5,
              decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(22)),
            ),
            SizedBox(
              width: width / 20,
            ),
            Column(
              children: [
                Text(
                  "Play basket ball",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse_outlined,
                      color: themeProvider.theme == ThemeMode.light
                          ? ColorApp.blackColor
                          : ColorApp.whiteColor,
                    ),
                    Text(
                      "10:30 AM",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height / 250, horizontal: width / 18),
              decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.check,
                color: themeProvider.theme == ThemeMode.light
                    ? ColorApp.whiteColor
                    : ColorApp.itemsDarkColor,
                size: 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
