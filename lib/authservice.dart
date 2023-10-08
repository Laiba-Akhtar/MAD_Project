import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      // Success message or navigation to a success screen
    } catch (e) {
      // Error handling, e.g., displaying an error message
    }
    return null;
  }
}
