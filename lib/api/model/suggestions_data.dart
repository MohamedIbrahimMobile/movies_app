import 'movie.dart';

class SuggestionsData {
  final int? movieCount;
  final List<Movie> movies;

  const SuggestionsData({this.movieCount, this.movies = const []});

  factory SuggestionsData.fromJson(Map<String, dynamic> json) {
    return SuggestionsData(
      movieCount: json['movie_count'],
      movies: json['movies'] != null
          ? (json['movies'] as List).map((e) => Movie.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_count': movieCount,
      'movies': movies.map((e) => e.toJson()).toList(),
    };
  }
}
