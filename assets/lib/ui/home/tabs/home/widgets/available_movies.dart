import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/image_error_placeholder.dart';

class AvailableMovies extends StatefulWidget {
  final List<Movie> movies;

  const AvailableMovies({super.key, required this.movies});

  @override
  State<AvailableMovies> createState() => _AvailableMoviesState();
}

class _AvailableMoviesState extends State<AvailableMovies> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            widget.movies[currentImageIndex].mediumCoverImage!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                ImageErrorPlaceholder(),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.blackColor.withValues(alpha: 0.8),
                  AppColors.blackColor.withValues(alpha: 0.6),
                  AppColors.blackColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        SafeArea(
          bottom: false,
          child: Column(
            spacing: context.height * 0.015,
            children: [
              Image.asset(
                AppAssets.availableNowText,
                height: context.height * 0.08,
              ),

              CarouselSlider.builder(
                itemCount: widget.movies.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.01,
                    ),
                    child: MovieCard(movie: widget.movies[index]),
                  );
                },
                options: CarouselOptions(
                  height: context.height * 0.33,
                  viewportFraction: context.width * 0.00142,
                  enlargeCenterPage: true,
                  enlargeFactor: context.width * 0.0008,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                ),
              ),

              Image.asset(
                AppAssets.watchNowText,
                height: context.height * 0.15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
