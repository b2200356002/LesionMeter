import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final GlobalKey<FormFieldState>? formFieldKey;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? icon;
  final Widget? suffix;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final bool expands;
  final bool obscureText;
  final int maxLines;
  final bool enabled;

  const CustomTextField({
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.autovalidateMode,
    this.inputFormatters,
    this.textInputType,
    this.formFieldKey,
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.icon,
    this.suffix,
    this.labelStyle,
    this.hintStyle,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.expands = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = this.focusNode ?? useFocusNode();
    useListenable(focusNode);

    return TextFormField(
      key: formFieldKey,
      initialValue: initialValue,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSaved: onSaved,
      obscureText: obscureText,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      keyboardType: textInputType,
      maxLines: maxLines,
      enabled: enabled,
      expands: expands,
      decoration: InputDecoration(
        suffixIconConstraints: suffixIconConstraints,
        prefixIconConstraints: prefixIconConstraints,
        icon: icon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        labelText: labelText,
      ),
    );
  }
}
