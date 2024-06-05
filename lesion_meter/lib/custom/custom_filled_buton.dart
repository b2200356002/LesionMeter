import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_circular_progress_bar.dart';

class CustomFilledButon extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget child;

  const CustomFilledButon({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: isLoading ? CustomCircularProgressIndicator(size: 24.r) : child,
    );
  }
}
