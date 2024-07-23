import 'package:flutter/material.dart';
import 'package:to_do_app/Home/to_do_list/task_item.dart';
import 'package:to_do_app/color_app.dart';

import '../widgets/EasyDateTimeLinePackage.dart';

class ToDOListTap extends StatelessWidget {
  const ToDOListTap({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => TaskItem(),
        ))
      ],
    );
  }
}
