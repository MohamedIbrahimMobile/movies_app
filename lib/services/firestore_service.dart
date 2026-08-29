import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/my_user.dart';
import 'package:movies_app/api/model/movie.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<MyUser> get _usersCollection {
    return _firestore
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();

        if (data == null) {
          throw Exception('User data is empty.');
        }

        return MyUser.fromFirestore(data);
      },
      toFirestore: (user, _) {
        return user.toFirestore();
      },
    );
  }

  Future<void> addUser(MyUser user) async {
    await _usersCollection.doc(user.id).set(user);
  }

  Future<MyUser?> getUser(String id) async {
    final snapshot = await _usersCollection.doc(id).get();

    return snapshot.data();
  }

  Stream<MyUser?> getUserStream(String id) {
    return _usersCollection
        .doc(id)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  Future<void> updateUser(MyUser user) async {
    await _usersCollection.doc(user.id).set(user);
  }

  Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }

  CollectionReference<Map<String, dynamic>> _watchListCollection(
      String userId,
      ) {
    return _firestore
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('watchList');
  }

  Future<void> addMovieToWatchList({
    required String userId,
    required Movie movie,
  }) async {
    if (movie.id == null) {
      throw Exception('Movie id is missing.');
    }

    await _watchListCollection(userId)
        .doc(movie.id.toString())
        .set({
      'movie': movie.toJson(),
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeMovieFromWatchList({
    required String userId,
    required int movieId,
  }) async {
    await _watchListCollection(userId)
        .doc(movieId.toString())
        .delete();
  }

  Future<bool> isMovieInWatchList({
    required String userId,
    required int movieId,
  }) async {
    final snapshot = await _watchListCollection(userId)
        .doc(movieId.toString())
        .get();

    return snapshot.exists;
  }

  Stream<List<Movie>> getWatchList(String userId) {
    return _watchListCollection(userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        final movieData = data['movie'];

        if (movieData is Map<String, dynamic>) {
          return Movie.fromJson(movieData);
        }

        return Movie.fromJson(
          Map<String, dynamic>.from(movieData),
        );
      }).toList();
    });
  }

  CollectionReference<Map<String, dynamic>> _historyCollection(
      String userId,
      ) {
    return _firestore
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('history');
  }

  Future<void> addMovieToHistory({
    required String userId,
    required Movie movie,
  }) async {
    if (movie.id == null) {
      throw Exception('Movie id is missing.');
    }

    await _historyCollection(userId)
        .doc(movie.id.toString())
        .set({
      'movie': movie.toJson(),
      'visitedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<int> getWatchListCount(String userId) async {
    final snapshot = await _watchListCollection(userId).count().get();
    return snapshot.count ?? 0;
  }

  Future<int> getHistoryCount(String userId) async {
    final snapshot = await _historyCollection(userId).count().get();
    return snapshot.count ?? 0;
  }

  Stream<List<Movie>> getHistory(String userId) {
    return _historyCollection(userId)
        .orderBy('visitedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        final movieData = data['movie'];

        if (movieData is Map<String, dynamic>) {
          return Movie.fromJson(movieData);
        }

        return Movie.fromJson(
          Map<String, dynamic>.from(movieData),
        );
      }).toList();
    });
  }
}