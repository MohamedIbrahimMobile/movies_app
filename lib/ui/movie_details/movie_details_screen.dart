import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/api/model/movies.dart';
import 'package:movies_app/cubit/movie_details_cubit.dart';
import 'package:movies_app/cubit/movie_details_state.dart';
import 'package:movies_app/ui/movie_details/widgets/screen_shot_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/stat_chip_widget.dart';
import 'package:movies_app/ui/similar_movies/similar_movies.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movies movies;
  const MovieDetailsScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsCubit(DioManager())
        ..getMovieDetails(movies.data?.movie?.id ?? 0),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieLoadingState) {
              return const MainLoadingWidget();
            } else if (state is MovieErrorState) {
              return MainErrorWidget(
                errorMessage: state.errorMessage.isEmpty ? 'Try Again' : state.errorMessage,
                onPressed: () {
                  context.read<MovieDetailsCubit>().getMovieDetails(movies.data?.movie?.id ?? 0);
                },
              );
            } else if (state is MovieSuccessState) {
              final movie = state.movie;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          movie.mediumCoverImage ?? '',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: context.height * 0.6,
                        ),
                        Container(
                          height: context.height * 0.6,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.transparent,
                                AppColors.blackColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          top: context.height * 0.06,
                          left: context.width * 0.04,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(AppAssets.arrowBackIcon),
                          ),
                        ),
                        Positioned(
                          top: context.height * 0.06,
                          right: context.width * 0.04,
                          child: Image.asset(AppAssets.saveIcon),
                        ),
                        Positioned(
                          top: context.height * 0.3,
                          right: context.width * 0.4,
                          child: Image.asset(AppAssets.playImage),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
                      child: Column(
                        spacing: context.height * 0.02,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            onPressed: () async {
                              final String urlString = movie.url ?? '';
                              if (urlString.isNotEmpty) {
                                final Uri url = Uri.parse(urlString);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.inAppWebView);
                                }
                              }
                            },
                            child: Text(
                              'watch'.tr(),
                              style: AppStyles.bold20WhiteRoboto,
                            ),
                          ),
                          Row(
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
                          Text('screen_shots'.tr(),
                            style: AppStyles.bold24WhiteRoboto,
                          ),
                          ScreenShotWidget(
                            image: movie.largeScreenshotImage1 ?? '',
                          ),
                          ScreenShotWidget(
                            image: movie.largeScreenshotImage2 ?? '',
                          ),
                          ScreenShotWidget(
                            image: movie.largeScreenshotImage3 ?? '',
                          ),
                          SimilarMovies(
                            movieId: movie.id ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}