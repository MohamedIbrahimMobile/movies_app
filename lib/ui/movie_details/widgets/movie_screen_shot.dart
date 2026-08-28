import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/movie_details/widgets/screen_shot_widget.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieScreenShot extends StatelessWidget {
  final String screenshotImage1;
  final String screenshotImage2;
  final String screenshotImage3;

  const MovieScreenShot({
    super.key,
    required this.screenshotImage1,
    required this.screenshotImage2,
    required this.screenshotImage3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.height * 0.017,
      children: [
        Text('screen_shots'.tr(), style: AppStyles.bold24WhiteRoboto),
        Column(
          spacing: context.height * 0.015,
          children: [
            ScreenShotWidget(image: screenshotImage1),
            ScreenShotWidget(image: screenshotImage2),
            ScreenShotWidget(image: screenshotImage3),
          ],
        ),
      ],
    );
  }
}
