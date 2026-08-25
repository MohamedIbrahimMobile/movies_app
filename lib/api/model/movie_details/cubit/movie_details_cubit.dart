import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_manager.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  void getMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final response = await ApiManager.getMovieDetails(movieId);
      if (response != null && response.data?.movie != null) {
        emit(MovieDetailsSuccessState(response.data!.movie!));
      } else {
        emit(MovieDetailsErrorState('Failed to load movie details.'));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}