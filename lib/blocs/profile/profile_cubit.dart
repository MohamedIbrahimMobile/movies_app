import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  StreamSubscription<List<Movie>>? _watchListSubscription;
  StreamSubscription<List<Movie>>? _historySubscription;

  ProfileCubit(this._profileRepository)
      : super(const ProfileState());

  void startListening() {
    _watchListSubscription =
        _profileRepository.getWatchList().listen((movies) {
          final ids = movies
              .where((movie) => movie.id != null)
              .map((movie) => movie.id!)
              .toSet();

          emit(
            state.copyWith(
              watchList: movies,
              savedMovieIds: ids,
            ),
          );
        });

    _historySubscription =
        _profileRepository.getHistory().listen((movies) {
          emit(
            state.copyWith(
              history: movies,
            ),
          );
        });
  }

  Future<void> toggleWatchList(Movie movie) async {
    if (movie.id == null) {
      return;
    }

    try {
      final isSaved =
      await _profileRepository.isMovieInWatchList(movie.id!);

      if (isSaved) {
        await _profileRepository.removeMovieFromWatchList(
          movie.id!,
        );
      } else {
        await _profileRepository.addMovieToWatchList(movie);
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<bool> isMovieInWatchList(int movieId) {
    return _profileRepository.isMovieInWatchList(movieId);
  }

  Future<void> addMovieToHistory(Movie movie) async {
    try {
      await _profileRepository.addMovieToHistory(movie);
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _watchListSubscription?.cancel();
    _historySubscription?.cancel();
    return super.close();
  }
}