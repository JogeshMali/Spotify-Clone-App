import 'package:flutter/material.dart';

class BasicTextfield extends StatelessWidget {
  final String title;
  final Icon? icon;
  final TextEditingController? controller;
  const BasicTextfield({super.key, required this.title,this.icon ,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        suffixIcon: icon
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
