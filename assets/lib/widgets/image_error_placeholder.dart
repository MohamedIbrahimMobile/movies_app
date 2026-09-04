import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class ImageErrorPlaceholder extends StatelessWidget {
  final double width;
  final double height;

  const ImageErrorPlaceholder({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.darkGrayColor,
      child: Center(
        child: Icon(
          Icons.movie,
          size: context.width * 0.14,
          color: Colors.white,
        ),
      ),
    );
  }
}
