import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  late Future<List<Movie>> suggestionMovies;

  @override
  void initState() {
    super.initState();
    suggestionMovies = ApiManager.getSuggestionMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.height * 0.017,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('similar'.tr(), style: AppStyles.bold24WhiteRoboto),
        FutureBuilder<List<Movie>>(
          future: suggestionMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MainLoadingWidget(height: context.height * 0.16);
            }

            if (snapshot.hasError) {
              return MainErrorWidget(
                width: double.infinity,
                height: context.height * 0.16,
                message: snapshot.error.toString().replaceFirst(
                  'Exception: ',
                  '',
                ),
                onPressed: () {
                  setState(() {
                    suggestionMovies = ApiManager.getSuggestionMovies(
                      widget.movieId,
                    );
                  });
                },
              );
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return MainErrorWidget(
                width: double.infinity,
                height: context.height * 0.16,
                message: 'movie_not_found',
                onPressed: () {
                  setState(() {
                    suggestionMovies = ApiManager.getSuggestionMovies(
                      widget.movieId,
                    );
                  });
                },
              );
            }

            final movies = snapshot.data!;

            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.width * 0.04,
                mainAxisSpacing: context.height * 0.02,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
