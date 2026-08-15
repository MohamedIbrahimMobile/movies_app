import 'package:flutter/material.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/available_movies.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_category.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.samMendesImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.blackColor.withValues(
                alpha: 0.82,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.height * 0.02,
                ),
                child: Column(
                  children: [
                    AvailableMovies(),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    MovieCategory(),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}