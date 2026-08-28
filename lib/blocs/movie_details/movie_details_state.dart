import 'package:movies_app/api/model/movie.dart';

abstract class MovieDetailsState {}

class MovieInitialState extends MovieDetailsState {}

class MovieLoadingState extends MovieDetailsState {}

class MovieErrorState extends MovieDetailsState {
  final String errorMessage;

  MovieErrorState(this.errorMessage);
}

class MovieSuccessState extends MovieDetailsState {
  final Movie movie;

  MovieSuccessState(this.movie);
}
