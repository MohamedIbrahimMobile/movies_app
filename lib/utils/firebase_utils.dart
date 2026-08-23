import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) {
        return MyUser.fromFirestore(
          snapshot.data() ?? {},
        );
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
  }

  static Future<void> addUserInFirestore(MyUser user) async {
    await getUsersCollection()
        .doc(user.id)
        .set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    final snapshot = await getUsersCollection()
        .doc(id)
        .get();
    return snapshot.data();
  }

  static Future<void> updateUserInFirestore(MyUser user) async {
    await getUsersCollection()
        .doc(user.id)
        .set(user);
  }

  static Future<void> deleteUserFromFirestore(String id) async {
    await getUsersCollection()
        .doc(id)
        .delete();
  }
}