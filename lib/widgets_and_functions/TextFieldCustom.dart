import 'package:flutter/material.dart';

import '../theme_and_color/color_app.dart';

class Textfieldcustom extends StatelessWidget {
  final String lableText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const Textfieldcustom(
      {super.key,
      required this.lableText,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: lableText,
          errorStyle: TextStyle(
            fontSize: 12.0, // Set the font size of the error text
            color: Colors.red, // Set the color of the error text
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.primaryColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.redColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.redColor, width: 2),
          ),
        ),
      ),
    );
  }
}
