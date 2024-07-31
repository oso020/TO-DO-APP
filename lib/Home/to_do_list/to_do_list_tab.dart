import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Home/to_do_list/task_item.dart';
import 'package:to_do_app/providers/getTaskProvider.dart';

import '../../theme_and_color/color_app.dart';
import '../widgets/EasyDateTimeLinePackage.dart';

class ToDOListTap extends StatefulWidget {
  ToDOListTap({super.key});

  @override
  State<ToDOListTap> createState() => _ToDOListTapState();
}

class _ToDOListTapState extends State<ToDOListTap> {
  @override
  Widget build(BuildContext context) {
    var getTaskProvider = Provider.of<GetTaskProvider>(context);
    if (getTaskProvider.tasks.isEmpty) {
      getTaskProvider.getTaskFromFireStore();
    }
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              color: ColorApp.primaryColor,
              width: double.infinity,
              height: height / 10,
            ),
            const EasyDateTimeLinePackage()
          ],
        ),
        Expanded(
            child: getTaskProvider.tasks.isEmpty
                ? Center(
                    child: Text(
                    "Added Some Task",
                    style: Theme.of(context).textTheme.displayLarge,
                  ))
                : ListView.builder(
                    itemCount: getTaskProvider.tasks.length,
          itemBuilder: (context, index) => TaskItem(
            task: getTaskProvider.tasks[index],
          ),
        ))
      ],
    );
  }
}
