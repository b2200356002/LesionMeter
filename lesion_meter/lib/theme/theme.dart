import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart' as colors;
import '../constants/font_sizes.dart';
import '../constants/text_styles.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: colors.green),
  floatingActionButtonTheme: _floatingActionButtonTheme,
  dividerColor: colors.bodyTextcolor.withOpacity(0.1),
  inputDecorationTheme: _inputDecorationTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  scaffoldBackgroundColor: colors.white,
  dropdownMenuTheme: _dropdownMenuTheme,
  datePickerTheme: _datePickerThemeData,
  filledButtonTheme: _filledButtonTheme,
  dialogBackgroundColor: colors.white,
  bottomSheetTheme: _bottomSheetTheme,
  listTileTheme: _listTileTheme,
  snackBarTheme: _snackBarTheme,
  primaryTextTheme: _textTheme,
  dividerTheme: _dividerTheme,
  appBarTheme: _appBarTheme,
  dialogTheme: _dialogTheme,
  fontFamily: kFontFamily,
  textTheme: _textTheme,
  useMaterial3: true,
);

final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: colors.bodyTextcolor.withOpacity(0.4),
      width: 1.r,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: colors.bodyTextcolor.withOpacity(0.4),
      width: 1.r,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: colors.bodyTextcolor.withOpacity(0.4),
      width: 1.r,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: colors.bodyTextcolor.withOpacity(0.4),
      width: 1.r,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: colors.bodyTextcolor.withOpacity(0.4),
      width: 1.r,
    ),
  ),
  hintStyle: lightBodyLarge.copyWith(color: colors.bodyTextcolor.withOpacity(0.6)),
);

final _appBarTheme = AppBarTheme(
  surfaceTintColor: Colors.transparent,
  foregroundColor: colors.darkBlue,
  titleTextStyle: lightLabelMedium,
  backgroundColor: colors.white,
  centerTitle: true,
  elevation: 0,
);

final _dialogTheme = DialogTheme(
  backgroundColor: colors.white,
  surfaceTintColor: colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
);

final _floatingActionButtonTheme = FloatingActionButtonThemeData(
  sizeConstraints: BoxConstraints.expand(height: 72.r, width: 72.r),
  shape: const CircleBorder(),
  backgroundColor: colors.green,
  foregroundColor: colors.white,
  elevation: 0,
  focusElevation: 0,
  hoverElevation: 0,
  highlightElevation: 0,
  disabledElevation: 0,
);

final _textTheme = TextTheme(
  labelSmall: lightLabelSmall,
  labelMedium: lightLabelMedium,
  labelLarge: lightLabelLarge,
  bodySmall: lightBodySmall,
  bodyMedium: lightBodyMedium,
  bodyLarge: lightBodyLarge,
  titleSmall: lightTitleSmall,
  titleMedium: lightTitleMedium,
  titleLarge: lightTitleLarge,
  displaySmall: lightDisplaySmall,
);

final _dividerTheme = DividerThemeData(
  color: colors.bodyTextcolor.withOpacity(0.1),
  thickness: 1.r,
  space: 0,
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(colors.white),
    foregroundColor: MaterialStateProperty.all(colors.green),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: MaterialStatePropertyAll(lightLabelMedium),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
        side: BorderSide(color: colors.green, width: 1.r),
      ),
    ),
    minimumSize: MaterialStatePropertyAll(Size.fromHeight(52.h)),
  ),
);

final _dropdownMenuTheme = DropdownMenuThemeData(
  textStyle: lightBodyMedium,
  inputDecorationTheme: _inputDecorationTheme,
);

final _datePickerThemeData = DatePickerThemeData(
  dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) return colors.green;

    return null;
  }),
  dayForegroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.white;
    } else if (states.contains(MaterialState.disabled)) {
      return colors.bodyTextcolor.withOpacity(0.4);
    }
    return colors.bodyTextcolor;
  }),
  todayForegroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.white;
    }

    return colors.green;
  }),
  todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) return colors.green;

    return null;
  }),
  todayBorder: BorderSide(color: colors.green, width: 1.r),
  headerBackgroundColor: colors.green,
  dayStyle: lightBodyMedium,
  weekdayStyle: lightLabelSmall.copyWith(color: colors.darkBlue),
  headerHeadlineStyle: lightTitleLarge.copyWith(color: Colors.white),
);

final _filledButtonTheme = FilledButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) return colors.green.withOpacity(0.5);

      return colors.green;
    }),
    foregroundColor: MaterialStateProperty.all(colors.white),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: MaterialStatePropertyAll(lightLabelMedium),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))),
    minimumSize: MaterialStatePropertyAll(Size.fromHeight(52.h)),
  ),
);

final _bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: colors.white,
  dragHandleColor: colors.darkBlue,
  dragHandleSize: Size(48.r, 4.r),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
);

final _listTileTheme = ListTileThemeData(
  tileColor: colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  titleTextStyle: lightLabelSmall,
  iconColor: colors.green,
);

final _snackBarTheme = SnackBarThemeData(
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  backgroundColor: colors.green,
  contentTextStyle: lightBodyMedium.copyWith(color: colors.white),
  actionTextColor: colors.white,
);
