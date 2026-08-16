import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieCategory extends StatelessWidget {
  const MovieCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            AppAssets.watchNowText,
            height: context.height * 0.15,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Action',
              style: AppStyles.reg20WhiteRoboto,
            ),

            Text(
              'See More →',
              style: AppStyles.reg14YellowRoboto,
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: context.width * 0.035,
            mainAxisSpacing: context.height * 0.02,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                context.width * 0.035,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      AppAssets.samMendesImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: context.height * 0.005,
                    left: context.width * 0.01,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.018,
                        vertical: context.height * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkGrayColor,
                        borderRadius: BorderRadius.circular(
                          context.width * 0.025,
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
              ),
            );
          },
        ),
      ],
    );
  }
}