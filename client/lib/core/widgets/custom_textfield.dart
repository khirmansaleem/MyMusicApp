import 'package:flutter/material.dart';

// make the controller optional, not every textField requires controller.

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final bool isReadOnly;
  final VoidCallback? OnTap;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
    this.isReadOnly = false,
    this.OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: OnTap,
      decoration: InputDecoration(hintText: hintText),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing";
        } else {
          return null;
        }
      },
      controller: controller,
      obscureText: isObscure,
      readOnly: isReadOnly,
    );
  }
}
