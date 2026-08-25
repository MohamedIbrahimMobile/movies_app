import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/ui/cubit/movie_details_state.dart';



class MovieDetailsCubit extends Cubit<MovieDetailsState>{
  final DioManager dioManager;
  MovieDetailsCubit(this.dioManager) : super(MovieInitialState());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieLoadingState());
    try {
      final moviesResult = await dioManager.getMovies(movieId);

      if (moviesResult.data?.movie != null) {
        emit(MovieSuccessState(moviesResult.data!.movie!));
      } else {
        emit(MovieErrorState('Movie data not found.'));
      }
    } catch (e) {
      emit(MovieErrorState(e.toString().replaceAll('Exception: ' , '')));
    }
  }
}