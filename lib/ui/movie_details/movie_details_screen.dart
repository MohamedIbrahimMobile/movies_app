import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/data/repositories/profile_repository.dart';
import 'package:movies_app/ui/movie_details/widgets/custom_btn.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_cast.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_details_up_section.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_genres.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_screen_shot.dart';
import 'package:movies_app/ui/movie_details/widgets/movie_summary.dart';
import 'package:movies_app/ui/movie_details/widgets/similar_movies.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/image_error_placeholder.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final ProfileRepository _profileRepository = ProfileRepository();
  YoutubePlayerController? youtubeController;
  final ScrollController scrollController = ScrollController();
  late Future<Movie> movieDetails;

  bool isPlay = false;
  bool isSaved = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    movieDetails = ApiManager.getMovieDetails(widget.movieId);
    scrollController.addListener(scrollListener);
    _loadWatchListState();
  }

  Future<void> _loadWatchListState() async {
    try {
      final saved = await _profileRepository.isMovieInWatchList(widget.movieId);

      if (!mounted) return;

      setState(() {
        isSaved = saved;
      });
    } catch (e) {
      DialogUtils.showToast(message: 'load_watch_list_error');
    }
  }

  Future<void> _toggleWatchList(Movie movie) async {
    if (movie.id == null || isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (isSaved) {
        await _profileRepository.removeMovieFromWatchList(movie.id!);

        if (!mounted) return;

        setState(() {
          isSaved = false;
        });

        DialogUtils.showToast(message: 'removed_watch_list');
      } else {
        await _profileRepository.addMovieToWatchList(movie);

        if (!mounted) return;

        setState(() {
          isSaved = true;
        });

        DialogUtils.showToast(message: 'added_watch_list');
      }
    } catch (e) {
      if (!mounted) return;
      DialogUtils.showToast(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _addToHistory(Movie movie) async {
    if (movie.id == null) return;

    try {
      await _profileRepository.addMovieToHistory(movie);
    } catch (e) {
      DialogUtils.showToast(message: 'history_error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Movie>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MainLoadingWidget();
          }

          if (snapshot.hasError) {
            return Center(
              child: MainErrorWidget(
                message: snapshot.error.toString().replaceFirst(
                  'Exception: ',
                  '',
                ),
                onPressed: () {
                  setState(() {
                    movieDetails = ApiManager.getMovieDetails(widget.movieId);
                  });
                },
              ),
            );
          }

          if (snapshot.data == null) {
            return Center(
              child: MainErrorWidget(
                message: 'movie_not_found',
                onPressed: () {
                  setState(() {
                    movieDetails = ApiManager.getMovieDetails(widget.movieId);
                  });
                },
              ),
            );
          }
          final Movie movie = snapshot.data!;
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
                            movie.mediumCoverImage ?? '',
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
                              isPlay ? Icons.close : Icons.arrow_back_ios_new,
                              color: AppColors.whiteColor,
                            ),
                          ),

                          CustomBtn(
                            isPlay: isPlay,
                            onTap: () {
                              _toggleWatchList(movie);
                            },
                            child: isLoading
                                ? SizedBox(
                                    width: context.width * 0.06,
                                    height: context.width * 0.06,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.yellowColor,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.bookmark_rounded,
                                    size: context.width * 0.075,
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
                        MovieDetailsUpSection(
                          movie: movie,
                          onWatchTap: () {
                            _addToHistory(movie);
                          },
                        ),

                        MovieScreenShot(
                          screenshotImage1: movie.mediumScreenshotImage1 ?? '',
                          screenshotImage2: movie.mediumScreenshotImage2 ?? '',
                          screenshotImage3: movie.mediumScreenshotImage3 ?? '',
                        ),

                        SimilarMovies(movieId: movie.id!),

                        MovieSummary(summary: movie.descriptionFull ?? ''),

                        MovieCast(castList: movie.cast),

                        MovieGenres(genres: movie.genres),

                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
