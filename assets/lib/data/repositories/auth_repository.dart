import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/models/my_user.dart';
import 'package:movies_app/services/firestore_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirestoreService _firestoreService = FirestoreService();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarIndex,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('Registration failed, please try again.');
    }

    final newUser = MyUser(
      id: firebaseUser.uid,
      email: email,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );

    await _firestoreService.addUser(newUser);
  }

  Future<void> login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginWithGoogle() async {
    await _googleSignIn.initialize();

    final googleUser = await _googleSignIn.authenticate();

    final googleAuthentication = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('Google login failed.');
    }

    final existingUser = await _firestoreService.getUser(firebaseUser.uid);

    if (existingUser == null) {
      final newUser = MyUser(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
        phone: firebaseUser.phoneNumber ?? '',
        avatarIndex: 0,
      );

      await _firestoreService.addUser(newUser);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<MyUser?> getCurrentUserProfile() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return await _firestoreService.getUser(firebaseUser.uid);
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      throw Exception('User is not logged in.');
    }

    final currentUser = await _firestoreService.getUser(firebaseUser.uid);

    if (currentUser == null) {
      throw Exception('User data not found.');
    }

    currentUser.name = name;
    currentUser.phone = phone;
    currentUser.avatarIndex = avatarIndex;

    await _firestoreService.updateUser(currentUser);
  }

  Future<void> deleteAccount() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      throw Exception('User is not logged in.');
    }

    await _firestoreService.deleteUser(firebaseUser.uid);

    await firebaseUser.delete();

    await _googleSignIn.signOut();
  }
}
