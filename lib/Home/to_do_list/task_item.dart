import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

import '../../model/task_model.dart';
import '../../providers/getTaskProvider.dart';
import '../../theme_and_color/color_app.dart';
import '../../widgets_and_functions/dialog_model.dart';
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
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: height / 50, horizontal: width / 25),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                deleteTask();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),

        child: widget.task.isDone == false ? notDoneWidget() : doneWidget(),
      ),
    );
  }

  doneTask() {
    DailogUtils.showLoading(context);
    getTaskProvider.isDone = true;
    getTaskProvider.doneTask(widget.task.id).timeout(const Duration(seconds: 1),
        onTimeout: () {
      getTaskProvider.getTaskFromFireStore();
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
        title: "Success",
        content: "Finished Task Successfully",
        context: context,
        button1Name: "Ok",
      );
    });
  }

  Widget notDoneWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            height: height / 7,
            width: 5,
            decoration: BoxDecoration(
                color: ColorApp.primaryColor,
                borderRadius: BorderRadius.circular(22)),
          ),
          SizedBox(
            width: width / 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChangeDetilesTaskScreen.routeName,
                  arguments: widget.task);
            },
            child: Column(
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
              icon: const Icon(
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
    );
  }

  Widget doneWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: themeProvider.theme == ThemeMode.light
              ? ColorApp.whiteColor
              : ColorApp.itemsDarkColor,
          borderRadius: BorderRadius.circular(15)),
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
            AppLocalizations.of(context)!.done,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ColorApp.greenColor, fontSize: 28),
          ),
        ],
      ),
    );
  }

  Future<void> deleteTask() {
    DailogUtils.showLoading(context);
    return getTaskProvider
        .deleteFromFireStore(widget.task.id)
        .timeout(const Duration(seconds: 1), onTimeout: () {
      getTaskProvider.getTaskFromFireStore();
      DailogUtils.hideLoading(context);
      DailogUtils.showMessage(
        title: "Success",
        content: "Deleted Successfully",
        context: context,
        button1Name: "Ok",
      );
    });
  }
}
