import 'package:flutter/material.dart';
import 'package:movies_app/utils/size_utils.dart';

class ScreenShotWidget extends StatelessWidget {
  final String image;
  final double? radius;

  const ScreenShotWidget({super.key, required this.image, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 16),
      ),
      child: Image.network(image, fit: BoxFit.cover),
    );
  }
}
