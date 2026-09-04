import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHandler {
  static String handle(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'email_already_in_use';

        case 'invalid-email':
          return 'invalid_email';

        case 'weak-password':
          return 'weak_password';

        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'invalid_login_credentials';

        case 'user-disabled':
          return 'user_disabled';

        case 'network-request-failed':
          return 'network_error';

        case 'popup-closed-by-user':
        case 'cancelled-popup-request':
          return 'google_sign_in_cancelled';

        case 'too-many-requests':
          return 'too_many_requests';

        default:
          return 'something_went_wrong';
      }
    }

    return 'something_went_wrong';
  }
}
