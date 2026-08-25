import 'package:flutter/material.dart';

class ScreenShotWidget extends StatelessWidget {
  final String image;
  final double? radius;
  const ScreenShotWidget({super.key, required this.image , this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 16),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        ),
    );
  }
}
