import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) submitForm;
  final String label;
  TextInputType? textInputType = TextInputType.text;

  AdaptativeTextField(
      {required this.controller,
      required this.submitForm,
      required this.label,
      this.textInputType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            onSubmitted: submitForm,
            keyboardType: textInputType,
            placeholder: label,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          )
        : TextField(
            controller: controller,
            onSubmitted: submitForm,
            decoration: InputDecoration(
              labelText: label,
            ),
            keyboardType: textInputType,
          );
  }
}
