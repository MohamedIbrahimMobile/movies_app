import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class StatChipWidget extends StatelessWidget {
  final String image;
  final String label;
  final Color colorContainer;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? radius;

  const StatChipWidget({
    super.key,
    required this.image,
    required this.label,
    required this.colorContainer,
    this.verticalPadding,
    this.horizontalPadding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 6),
        decoration: BoxDecoration(
          color: colorContainer,
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.width * 0.02,
          children: [
            Image.asset(image),
            Text(label, style: AppStyles.bold24WhiteRoboto),
          ],
        ),
      ),
    );
  }
}
