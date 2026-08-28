import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/movie_details/movie_details_cubit.dart';
import 'package:movies_app/blocs/movie_details/movie_details_state.dart';
import 'package:movies_app/ui/movie_details/widgets/custom_btn.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_cast.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_details_up_section.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_genres.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_screen_shot.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_summary.dart';
import 'package:movies_app/ui/movie_details/widgets/similar_movies.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/image_error_placeholder.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isSaved = false;
  bool isPlay = false;

  YoutubePlayerController? youtubeController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => MovieDetailsCubit()..getMovieDetails(movieId),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieLoadingState) {
              return const MainLoadingWidget();
            }

            if (state is MovieErrorState) {
              return Center(
                child: MainErrorWidget(
                  message: state.errorMessage,
                  onPressed: () => context
                      .read<MovieDetailsCubit>()
                      .getMovieDetails(movieId),
                ),
              );
            }

            if (state is MovieSuccessState) {
              final movie = state.movie;

              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        isPlay
                            ? SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: context.height * 0.12,
                                  ),
                                  child: YoutubePlayer(
                                    controller: youtubeController!,
                                    aspectRatio: 8 / 6,
                                  ),
                                ),
                              )
                            : Image.network(
                                movie.mediumCoverImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: context.height * 0.6,
                                errorBuilder: (context, error, stackTrace) {
                                  return ImageErrorPlaceholder(
                                    height: context.height * 0.6,
                                  );
                                },
                              ),

                        if (!isPlay)
                          Container(
                            height: context.height * 0.6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.blackColor.withValues(alpha: 0.2),
                                  AppColors.blackColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),

                        Positioned(
                          top: context.height * 0.065,
                          left: context.width * 0.04,
                          right: context.width * 0.04,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomBtn(
                                isPlay: isPlay,
                                onTap: () {
                                  if (isPlay) {
                                    closeBtn();
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Icon(
                                  isPlay
                                      ? Icons.close
                                      : Icons.arrow_back_ios_new,
                                  color: AppColors.whiteColor,
                                ),
                              ),

                              CustomBtn(
                                isPlay: isPlay,
                                onTap: () {
                                  isSaved = !isSaved;
                                  setState(() {});
                                },
                                child: Icon(
                                  size: context.width * 0.075,
                                  Icons.bookmark_rounded,
                                  color: isSaved
                                      ? AppColors.yellowColor
                                      : AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (!isPlay &&
                            movie.ytTrailerCode != null &&
                            movie.ytTrailerCode!.isNotEmpty)
                          Positioned(
                            top: context.height * 0.28,
                            child: InkWell(
                              onTap: () {
                                playTrailer(movie.ytTrailerCode!);
                              },
                              child: Image.asset(AppAssets.playImage),
                            ),
                          ),
                      ],
                    ),

                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.04,
                        ),
                        child: Column(
                          spacing: context.height * 0.05,
                          children: [
                            MovieDetailsUpSection(movie: movie),
                            MovieScreenShot(
                              screenshotImage1:
                                  movie.mediumScreenshotImage1 ?? '',
                              screenshotImage2:
                                  movie.mediumScreenshotImage2 ?? '',
                              screenshotImage3:
                                  movie.mediumScreenshotImage3 ?? '',
                            ),
                            SimilarMovies(movieId: movie.id!),
                            MovieSummary(summary: movie.descriptionFull ?? ''),
                            MovieCast(castList: movie.cast),
                            MovieGenres(genres: movie.genres),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void playTrailer(String trailerCode) {
    if (trailerCode.isEmpty) return;

    youtubeController = YoutubePlayerController.fromVideoId(
      videoId: trailerCode,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    setState(() {
      isPlay = true;
    });
  }

  void scrollListener() {
    if (youtubeController?.value.playerState == PlayerState.playing) {
      youtubeController?.pauseVideo();
    }
  }

  void closeBtn() {
    youtubeController?.close();
    setState(() {
      youtubeController = null;
      isPlay = false;
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    youtubeController?.close();
    super.dispose();
  }
}
