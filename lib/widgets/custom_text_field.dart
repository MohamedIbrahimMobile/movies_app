import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final double? radius;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool fill;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
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
    this.fill = true,
    this.fillColor = AppColors.darkGrayColor,
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
    final fieldRadius = radius ?? 15;
    final fieldBorderColor = borderColor ?? AppColors.darkGrayColor;

    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: _buildBorder(
          radius: fieldRadius,
          borderColor: fieldBorderColor,
        ),
        focusedBorder: _buildBorder(
          radius: fieldRadius,
          borderColor: fieldBorderColor,
        ),
        errorBorder: _buildBorder(
          radius: fieldRadius,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: _buildBorder(
          radius: fieldRadius,
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: fillColor,
        filled: fill,
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

  OutlineInputBorder _buildBorder({
    required double radius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
