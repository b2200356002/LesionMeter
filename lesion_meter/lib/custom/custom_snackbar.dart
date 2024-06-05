import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String title;

  CustomSnackBar({required this.title}) : super(content: Text(title));

  void show(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(this);
}
