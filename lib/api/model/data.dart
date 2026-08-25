import 'movie.dart';

class Data {
  Movie? movie;
  int? movieCount;
  List<Movie>? movies; // ✅ الخاصية المطلوبة

  Data({
    this.movie,
    this.movieCount,
    this.movies,
  });

  Data.fromJson(dynamic json) {
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    if (movieCount != null) {
      map['movie_count'] = movieCount;
    }
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}