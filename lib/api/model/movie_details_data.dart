import 'movie.dart';

class MovieDetailsData {
  final Movie? movie;

  const MovieDetailsData({this.movie});

  factory MovieDetailsData.fromJson(Map<String, dynamic> json) {
    return MovieDetailsData(
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'movie': movie?.toJson()};
  }
}
