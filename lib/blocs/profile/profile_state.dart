import 'package:movies_app/api/model/movie.dart';

class ProfileState {
  final bool isLoading;
  final Set<int> savedMovieIds;
  final List<Movie> watchList;
  final List<Movie> history;
  final String? errorMessage;

  const ProfileState({
    this.isLoading = false,
    this.savedMovieIds = const {},
    this.watchList = const [],
    this.history = const [],
    this.errorMessage,
  });

  ProfileState copyWith({
    bool? isLoading,
    Set<int>? savedMovieIds,
    List<Movie>? watchList,
    List<Movie>? history,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      savedMovieIds: savedMovieIds ?? this.savedMovieIds,
      watchList: watchList ?? this.watchList,
      history: history ?? this.history,
      errorMessage: errorMessage,
    );
  }
}