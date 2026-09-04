import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieCategory extends StatelessWidget {
  final String selectedCategory;
  final List<Movie> movies;
  final VoidCallback onTap;

  const MovieCategory({
    super.key,
    required this.selectedCategory,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: context.width * 0.04,
      ),
      child: Column(
        spacing: context.height * 0.012,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: context.width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory.tr(),
                  style: AppStyles.reg20WhiteRoboto,
                ),

                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    spacing: context.height * 0.006,
                    children: [
                      Text(
                        'see_more'.tr(),
                        style: AppStyles.reg16YellowRoboto,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.yellowColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: context.height * 0.265,
            child: ListView.separated(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    MovieCard(
                      movie: movies[index],
                      width: context.width * 0.38,
                    ),

                    if (index == movies.length - 1)
                      SizedBox(
                        width: context.width * 0.04,
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: context.width * 0.04,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}