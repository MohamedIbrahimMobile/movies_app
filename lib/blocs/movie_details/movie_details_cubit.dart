import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';

import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieInitialState());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieLoadingState());

    try {
      final response = await ApiManager.getMovieDetails(movieId);

      final movie = response?.data?.movie;

      if (movie == null) {
        emit(MovieErrorState('Movie data not found.'));
        return;
      }

      emit(MovieSuccessState(movie));
    } catch (e) {
      emit(MovieErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
