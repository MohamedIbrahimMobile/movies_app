import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

typedef OnPageChanged = dynamic Function(
    int,
    CarouselPageChangedReason,
    )?;

class AvailableMovies extends StatefulWidget {
  const AvailableMovies({super.key});

  @override
  State<AvailableMovies> createState() => _AvailableMoviesState();
}

class _AvailableMoviesState extends State<AvailableMovies> {
  late Future<List<Movie>> movies;

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    movies = ApiManager.getMovies(
      sortBy: 'date_added',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.64,
      child: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MainLoadingWidget();
          }

          if (snapshot.hasError) {
            return MainErrorWidget(
              message: snapshot.error.toString(),
              onPressed: () {
                setState(() {
                  movies = ApiManager.getMovies(
                    sortBy: 'date_added',
                  );
                });
              },
            );
          }

          final moviesList = snapshot.data ?? [];

          if (moviesList.isEmpty) {
            return const SizedBox();
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                moviesList[currentImageIndex].mediumCoverImage ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Container(
                    color: AppColors.blackColor,
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.blackColor.withValues(
                        alpha: 0.8,
                      ),
                      AppColors.blackColor.withValues(
                        alpha: 0.6,
                      ),
                      AppColors.blackColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: context.height * 0.025,),
                  Image.asset(
                    AppAssets.availableNowText,
                    height: context.height * 0.08,
                  ),

                  SizedBox(
                    height: context.height * 0.015,
                  ),
                  CarouselSlider.builder(
                    itemCount: moviesList.length,
                    itemBuilder: (
                        context, index,
                        realIndex,
                        ) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.01,
                        ),
                        child: MovieCard(
                          movie: moviesList[index],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: context.height * 0.33,
                      viewportFraction:
                      context.width * 0.00142,
                      enlargeCenterPage: true,
                      enlargeFactor:
                      context.width * 0.0008,
                      onPageChanged: (
                          index,
                          reason,
                          ) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: context.height * 0.005,),
                  Image.asset(
                    AppAssets.watchNowText,
                    height: context.height * 0.15,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}