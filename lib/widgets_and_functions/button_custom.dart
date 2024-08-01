import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ButtonCustom({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text));
  }
}
