import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/api/model/suggestions.dart';
import 'package:movies_app/ui/similar_movies/widgets/similar_movies_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;

  const SimilarMovies({
    super.key,
    required this.movieId,
  });

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final DioManager _dioManager = DioManager();

  late Future<Suggestions?> _suggestionsFuture;

  @override
  void initState() {
    super.initState();
    _fetchSuggestions();
  }

  @override
  void didUpdateWidget(covariant SimilarMovies oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.movieId != widget.movieId) {
      _fetchSuggestions();
    }
  }

  void _fetchSuggestions() {
    _suggestionsFuture = _dioManager.getSuggestionMovies(
      widget.movieId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Suggestions?>(
      future: _suggestionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          return MainErrorWidget(
            errorMessage: snapshot.error.toString(),
            onPressed: () {
              setState(() {
                _fetchSuggestions();
              });
            },
          );
        }
        if (!snapshot.hasData ||
            snapshot.data?.status != 'ok') {
          return MainErrorWidget(
            errorMessage: 'Try Again',
            onPressed: () {
              setState(() {
                _fetchSuggestions();
              });
            },
          );
        }
        final movies =
            snapshot.data?.data?.movies ?? [];

        if (movies.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('similar'.tr(),
              style: AppStyles.bold24WhiteRoboto,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60,
                crossAxisSpacing: context.width * 0.04,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return SimilarMoviesWidget(
                  movieImage:
                  movie.mediumCoverImage ?? '',
                  movieRating:
                  movie.rating ?? 0.0,
                  ratingImage:
                  AppAssets.starIcon,
                );
              },
            ),
          ],
        );
      },
    );
  }
}