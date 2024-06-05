import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? size;

  const CustomCircularProgressIndicator({this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
  }
}
