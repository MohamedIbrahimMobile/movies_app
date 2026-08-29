import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/services/firestore_service.dart';

class ProfileRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  String get _userId {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return user.uid;
  }

  Future<void> addMovieToWatchList(Movie movie) {
    return _firestoreService.addMovieToWatchList(
      userId: _userId,
      movie: movie,
    );
  }

  Future<void> removeMovieFromWatchList(int movieId) {
    return _firestoreService.removeMovieFromWatchList(
      userId: _userId,
      movieId: movieId,
    );
  }

  Future<bool> isMovieInWatchList(int movieId) {
    return _firestoreService.isMovieInWatchList(
      userId: _userId,
      movieId: movieId,
    );
  }

  Stream<List<Movie>> getWatchList() {
    return _firestoreService.getWatchList(_userId);
  }


  Future<void> addMovieToHistory(Movie movie) {
    return _firestoreService.addMovieToHistory(
      userId: _userId,
      movie: movie,
    );
  }

  Stream<List<Movie>> getHistory() {
    return _firestoreService.getHistory(_userId);
  }
}