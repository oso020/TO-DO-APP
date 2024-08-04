import 'package:flutter/material.dart';

class DailogUtils {
  static showLoading(BuildContext context, Color color) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color,
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessage({
    required BuildContext context,
    required Color color,
    required String content,
    required String title,
    String? button1Name,
    Function? button1Function,
    String? button2Name,
    Function? button2Function,
      bool? barrierDismissible}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (context) {
        List<Widget> actions = [];
        if (button1Name != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                button1Function?.call();
              },
              child: Text(
                button1Name,
                style: Theme.of(context).textTheme.bodySmall,
              )));
        }
        if (button2Name != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                button2Function?.call();
              },
              child: Text(
                button2Name,
                style: Theme.of(context).textTheme.bodySmall,
              )));
        }
        return AlertDialog(
          backgroundColor: color,
          content: Text(
            content,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: actions,
        );
      },
    );
  }
}
