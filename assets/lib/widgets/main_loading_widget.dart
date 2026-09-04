import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class MainLoadingWidget extends StatelessWidget {
  final double? height;

  const MainLoadingWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.yellowColor),
        ),
      ),
    );
  }
}
