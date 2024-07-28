import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

import '../../model/task_model.dart';
import '../../providers/getTaskProvider.dart';
import '../../theme_and_color/color_app.dart';
import 'change_detiles_task_screen.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late GetTaskProvider getTaskProvider;
  late ThemeProvider themeProvider;

  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    themeProvider = Provider.of<ThemeProvider>(context);
    getTaskProvider = Provider.of<GetTaskProvider>(context);
    return widget.task.isDone == false ? notDoneWidget() : doneWidget();
  }

  doneTask() {
    getTaskProvider.isDone = true;
    getTaskProvider.doneTask(widget.task.id).timeout(Duration(seconds: 1),
        onTimeout: () {
      print("done Task");
    });
    getTaskProvider.getTaskFromFireStore();
  }

  Widget notDoneWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChangeDetilesTaskScreen.routeName,
            arguments: widget.task);
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
                  widget.task.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  widget.task.description,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height / 300, horizontal: width / 24),
              decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  doneTask();
                },
                icon: Icon(
                  Icons.check,
                  size: 33,
                ),
                color: themeProvider.theme == ThemeMode.light
                    ? ColorApp.whiteColor
                    : ColorApp.itemsDarkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doneWidget() {
    return Container(
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
                color: ColorApp.greenColor,
                borderRadius: BorderRadius.circular(22)),
          ),
          SizedBox(
            width: width / 20,
          ),
          Column(
            children: [
              Text(
                widget.task.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorApp.greenColor,
                    ),
              ),
              SizedBox(
                height: height / 100,
              ),
              Text(
                widget.task.description,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorApp.greenColor,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "Done!",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ColorApp.greenColor, fontSize: 33),
          ),
        ],
      ),
    );
  }
}
