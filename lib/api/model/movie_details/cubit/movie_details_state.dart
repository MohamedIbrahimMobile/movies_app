import '../Movie.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInitialState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsSuccessState extends MovieDetailsStates {
  final Movie movie;

  MovieDetailsSuccessState(this.movie);
}

class MovieDetailsErrorState extends MovieDetailsStates {
  final String errorMessage;

  MovieDetailsErrorState(this.errorMessage);
}
