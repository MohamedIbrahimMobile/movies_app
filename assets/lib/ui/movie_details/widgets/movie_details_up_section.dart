import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/movie_details/widgets/stat_chip_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsUpSection extends StatelessWidget {
  final Movie movie;
  final VoidCallback onWatchTap;

  const MovieDetailsUpSection({
    super.key,
    required this.movie,
    required this.onWatchTap,
  });

  Future<void> _watchMovie() async {
    onWatchTap();

    final String urlString = movie.url ?? '';

    if (urlString.isEmpty) {
      return;
    }

    final Uri? url = Uri.tryParse(urlString);

    if (url == null) {
      return;
    }

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.height * 0.02,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(),
        Text(
          movie.title ?? '',
          textAlign: TextAlign.center,
          style: AppStyles.bold24WhiteRoboto,
        ),

        Text(
          '${movie.year ?? ''}',
          textAlign: TextAlign.center,
          style: AppStyles.bold20LightGrayRoboto,
        ),

        CustomElevatedButton(
          backgroundColor: AppColors.redColor,
          verticalPadding: context.height * 0.015,
          onPressed: _watchMovie,
          child: Text('watch'.tr(), style: AppStyles.bold20WhiteRoboto),
        ),

        Row(
          spacing: context.width * 0.025,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatChipWidget(
              colorContainer: AppColors.darkGrayColor,
              image: AppAssets.favoriteIcon,
              label: '${movie.likeCount ?? 0}',
            ),

            StatChipWidget(
              colorContainer: AppColors.darkGrayColor,
              image: AppAssets.timeIcon,
              label: '${movie.runtime ?? 0}',
            ),

            StatChipWidget(
              colorContainer: AppColors.darkGrayColor,
              image: AppAssets.starIcon,
              label: '${movie.rating ?? 0.0}',
            ),
          ],
        ),
      ],
    );
  }
}
