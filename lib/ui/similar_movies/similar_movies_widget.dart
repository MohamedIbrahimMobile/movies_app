import 'package:flutter/material.dart';
import 'package:movies_app/ui/similar_movies/movie_rating.dart';
import 'package:movies_app/utils/size_utils.dart';

class SimilarMoviesWidget extends StatelessWidget {

  String movieImage;
  String ratingImage;
  double movieRating;

   SimilarMoviesWidget({super.key,
    required this.movieImage,
    required this.ratingImage,
     required this.movieRating});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(movieImage,
              height: context.height*0.3,
              width: context.width*0.5,
              fit: BoxFit.fill,
            ),
          ),
        Container(
          child: MovieRating(
              movieRating: movieRating,
            ratingImage: ratingImage,
          )
        ),

      ],
    );
  }
}
