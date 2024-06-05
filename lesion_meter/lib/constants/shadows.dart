import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;

final bottomBarShadow = BoxShadow(
  color: colors.bodyTextcolor.withOpacity(0.05),
  offset: Offset(0, -8.h),
  blurRadius: 16.r,
);
