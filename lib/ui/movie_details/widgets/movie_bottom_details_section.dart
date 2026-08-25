import 'package:flutter/material.dart';
import '../../../../api/model/movie_details/Movie.dart';
import '../../../../utils/size_utils.dart';
import 'movie_summary.dart';
import 'movie_cast.dart';
import 'movie_genres.dart';

class MovieBottomDetailsSection extends StatelessWidget {
  final Movie movie;

  const MovieBottomDetailsSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieSummary(summary: movie.descriptionFull ?? ''),
        SizedBox(height: context.height * 0.02),
        MovieCast(castList: movie.cast),
        SizedBox(height: context.height * 0.02),
        MovieGenres(genres: movie.genres),
      ],
    );
  }
}
