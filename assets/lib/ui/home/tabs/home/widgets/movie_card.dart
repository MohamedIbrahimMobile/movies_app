import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/image_error_placeholder.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double? width;
  final double? height;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double radius;

  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.horizontalMargin,
    this.verticalMargin,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetailsScreenRouteName,
          arguments: movie.id,
        );
      },
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.network(
              movie.mediumCoverImage ?? '',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Stack(
                children: [
                  ImageErrorPlaceholder(),
                  Container(color: AppColors.blackColor.withValues(alpha: 0.5)),
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: horizontalMargin ?? context.width * 0.024,
                  vertical: verticalMargin ?? context.height * 0.012,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.02,
                  vertical: context.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: context.width * 0.007,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.rating.toString(),
                      style: AppStyles.reg16WhiteRoboto,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                      size: context.width * 0.04,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
