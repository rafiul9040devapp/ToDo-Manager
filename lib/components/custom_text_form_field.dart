import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxLength;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(hintText: hintText),
      validator: validator,
    );
  }
}
