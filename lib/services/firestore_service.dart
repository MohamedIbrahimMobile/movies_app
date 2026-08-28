import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/my_user.dart';

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

  Future<void> updateUser(MyUser user) async {
    await _usersCollection.doc(user.id).set(user);
  }

  Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }
}
