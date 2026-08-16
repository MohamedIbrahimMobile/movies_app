import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class AvailableMovies extends StatelessWidget {
  const AvailableMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            AppAssets.availableNowText,
            height: context.height * 0.08,
          ),
        ),
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      context.width * 0.02,
                    ),
                    child: Image.asset(
                      AppAssets.samMendesImage,
                      height: context.height * 0.30,
                      width: context.width * 0.52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: context.height * 0.01,
                  left: context.width * 0.06,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.02,
                      vertical: context.height * 0.006,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkGrayColor,
                      borderRadius: BorderRadius.circular(
                        context.width * 0.03,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '7.7',
                          style: AppStyles.reg14YellowRoboto,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors.yellowColor,
                          size: context.height * 0.018,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: context.height * 0.31,
            viewportFraction: 0.60,
            enlargeCenterPage: true,
            enlargeFactor: 0.28,
          ),
        ),
      ],
    );
  }
}