import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart' as colors;
import '../../../../gen/assets.gen.dart';

enum _Type { info, failure }

abstract final class CustomDialog extends StatelessWidget {
  final VoidCallback? onMainButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final Color? mainButtonBackgroundColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final String title;
  final String? subtitle;
  final _Type type;

  const CustomDialog({
    required this.type,
    required this.title,
    required this.secondaryButtonText,
    this.subtitle,
    this.mainButtonBackgroundColor,
    this.onMainButtonPressed,
    this.onSecondaryButtonPressed,
    this.primaryButtonText,
  }) : assert(
          onMainButtonPressed == null && primaryButtonText == null ||
              onMainButtonPressed != null && primaryButtonText != null,
          "onMainButtonPressed and buttonText must be both null or both not null",
        );

  const factory CustomDialog.failure({
    required String title,
    String? subtitle,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onMainButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    Color? mainButtonBackgroundColor,
  }) = _FailureDialog;

  const factory CustomDialog.info({
    required String title,
    String? subtitle,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onMainButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    Color? mainButtonBackgroundColor,
  }) = _InfoDialog;

  Future<T?> show<T>(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (context) => this,
      );
    }

    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: colors.bodyTextcolor.withOpacity(0.4),
      builder: (context) => this,
    );
  }
}

final class _FailureDialog extends CustomDialog {
  const _FailureDialog({
    required super.title,
    super.subtitle,
    super.onMainButtonPressed,
    super.onSecondaryButtonPressed,
    super.mainButtonBackgroundColor,
    super.primaryButtonText,
    super.secondaryButtonText,
  }) : super(type: _Type.failure);

  @override
  Widget build(BuildContext context) {
    return _SimpleDialog(
      mainButtonBackgroundColor: mainButtonBackgroundColor,
      onMainButtonPressed: onMainButtonPressed,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
      secondaryButtonText: secondaryButtonText,
      primaryButtonText: primaryButtonText,
      title: title,
      subtitle: subtitle,
      type: type,
    );
  }
}

final class _InfoDialog extends CustomDialog {
  const _InfoDialog({
    required super.title,
    super.subtitle,
    super.onMainButtonPressed,
    super.onSecondaryButtonPressed,
    super.mainButtonBackgroundColor,
    super.primaryButtonText,
    super.secondaryButtonText,
  }) : super(type: _Type.info);

  @override
  Widget build(BuildContext context) {
    return _SimpleDialog(
      mainButtonBackgroundColor: mainButtonBackgroundColor,
      onMainButtonPressed: onMainButtonPressed,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
      secondaryButtonText: secondaryButtonText,
      primaryButtonText: primaryButtonText,
      title: title,
      subtitle: subtitle,
      type: type,
    );
  }
}

class _SimpleDialog extends StatelessWidget {
  final Color? mainButtonBackgroundColor;
  final VoidCallback? onMainButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final String title;
  final String? subtitle;
  final _Type type;

  const _SimpleDialog({
    required this.type,
    required this.title,
    this.subtitle,
    this.mainButtonBackgroundColor,
    this.onMainButtonPressed,
    this.onSecondaryButtonPressed,
    this.primaryButtonText,
    this.secondaryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _CupertinoDialog(
        onMainButtonPressed: onMainButtonPressed,
        onSecondaryButtonPressed: onSecondaryButtonPressed,
        secondaryButtonText: secondaryButtonText,
        buttonText: primaryButtonText,
        title: title,
        subtitle: subtitle,
      );
    }

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          child: Column(
            children: [
              _Icon(type: type),
              SizedBox(height: 24.h),
              _Title(text: title),
              if (subtitle != null) ...[
                SizedBox(height: 20.h),
                _Subtitle(text: subtitle!),
              ],
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(child: _GiveUpButton(text: secondaryButtonText, onPressed: onSecondaryButtonPressed)),
                  if (onMainButtonPressed != null) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _MainButton(
                        backgroundColor: mainButtonBackgroundColor,
                        onPressed: onMainButtonPressed!,
                        text: primaryButtonText!,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CupertinoDialog extends StatelessWidget {
  final VoidCallback? onMainButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final String? buttonText;
  final String? secondaryButtonText;
  final String title;
  final String? subtitle;

  const _CupertinoDialog({
    required this.title,
    this.subtitle,
    this.onMainButtonPressed,
    this.onSecondaryButtonPressed,
    this.secondaryButtonText,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: subtitle != null ? Text(subtitle!) : null,
      actions: [
        CupertinoDialogAction(
          onPressed: onSecondaryButtonPressed ?? context.maybePop,
          child: Text(secondaryButtonText ?? "Vazgeç"),
        ),
        if (onMainButtonPressed != null)
          CupertinoDialogAction(
            onPressed: onMainButtonPressed,
            isDestructiveAction: true,
            child: Text(buttonText!),
          ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final _Type type;

  const _Icon({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.r,
      width: 64.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: switch (type) { _Type.info => colors.yellow, _Type.failure => colors.red }.withOpacity(0.1),
      ),
      child: Assets.icons.alert.svg(
        height: 44.r,
        width: 44.r,
        colorFilter: switch (type) {
          _Type.info => null,
          _Type.failure => const ColorFilter.mode(colors.red, BlendMode.srcIn),
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String text;

  const _Subtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    );
  }
}

class _GiveUpButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  const _GiveUpButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? context.router.popForced,
      child: Text(text ?? "Vazgeç"),
    );
  }
}

class _MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String text;

  const _MainButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: backgroundColor),
      onPressed: onPressed,
      child: FittedBox(child: Text(text)),
    );
  }
}
