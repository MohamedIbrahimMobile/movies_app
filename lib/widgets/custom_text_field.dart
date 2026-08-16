import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final double? radius;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool? fill;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final OnChanged? onChanged;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;

  const CustomTextField({
    super.key,
    this.radius,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.fill = false,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.obscuringCharacter = '.',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationItem(
          radius: radius ?? 15,
          borderColor: borderColor ?? AppColors.darkGrayColor,
        ),
        focusedBorder: builtDecorationItem(
          radius: radius ?? 15,
          borderColor: borderColor ?? AppColors.darkGrayColor,
        ),
        errorBorder: builtDecorationItem(
          radius: radius ?? 15,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: builtDecorationItem(
          radius: radius ?? 15,
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: fillColor,
        filled: fill ?? false,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
    );
  }

  OutlineInputBorder builtDecorationItem({
    required double radius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
    );
  }
}