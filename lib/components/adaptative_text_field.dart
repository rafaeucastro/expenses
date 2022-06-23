import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) submitForm;
  final String label;
  final TextInputType textInputType;

  const AdaptativeTextField(
      {required this.controller,
      required this.submitForm,
      required this.label,
      required this.textInputType,
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
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
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
