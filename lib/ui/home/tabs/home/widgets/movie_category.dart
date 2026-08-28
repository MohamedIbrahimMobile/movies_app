import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class MovieCategory extends StatefulWidget {
  final String selectedCategory;
  final VoidCallback onTap;

  const MovieCategory({
    super.key,
    required this.selectedCategory,
    required this.onTap,
  });

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movies = ApiManager.getMovies(genre: widget.selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: context.height * 0.265,
            child: MainLoadingWidget(),
          );
        } else if (snapshot.hasError) {
          return MainErrorWidget(
            message: snapshot.error.toString(),
            onPressed: () {
              movies = ApiManager.getMovies(genre: widget.selectedCategory);
              setState(() {});
            },
          );
        } else {
          List<Movie> moviesList = snapshot.data!;
          return Padding(
            padding: EdgeInsetsDirectional.only(start: context.width * 0.04),
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
                        widget.selectedCategory.tr(),
                        style: AppStyles.reg20WhiteRoboto,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
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
                    itemCount: moviesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          MovieCard(
                            movie: moviesList[index],
                            width: context.width * 0.38,
                          ),
                          Visibility(
                            visible: index == moviesList.length - 1,
                            child: SizedBox(width: context.width * 0.04),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: context.width * 0.04);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
