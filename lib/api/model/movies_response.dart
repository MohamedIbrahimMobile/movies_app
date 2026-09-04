import 'movie.dart';

class MoviesResponse {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<Movie> movies;

  const MoviesResponse({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  MoviesResponse.fromJson(Map<String, dynamic> json)
    : this(
        movieCount: json['movie_count'] ?? 0,
        limit: json['limit'] ?? 0,
        pageNumber: json['page_number'] ?? 1,
        movies:
            (json['movies'] as List?)?.map((e) => Movie.fromJson(e)).toList() ??
            [],
      );

  int get totalPages {
    if (limit == 0) return 0;
    return (movieCount / limit).ceil();
  }

  bool get hasNextPage {
    return pageNumber < totalPages;
  }
}
