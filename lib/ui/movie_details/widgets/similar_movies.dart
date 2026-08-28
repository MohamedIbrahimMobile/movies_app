import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/suggestions.dart';
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
  late Future<Suggestions?> suggestionMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestionMovies = ApiManager.getSuggestionMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Suggestions?>(
      future: suggestionMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          return MainErrorWidget(
            message: snapshot.error.toString(),
            onPressed: () {
              setState(() {
                suggestionMovies = ApiManager.getSuggestionMovies(
                  widget.movieId,
                );
              });
            },
          );
        }
        final movies = snapshot.data!.data!.movies;

        if (movies.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('similar'.tr(), style: AppStyles.bold24WhiteRoboto),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.width * 0.04,
                mainAxisSpacing: context.height * 0.02,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            ),
          ],
        );
      },
    );
  }
}
