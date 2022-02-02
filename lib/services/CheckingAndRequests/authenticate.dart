import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // anon sign in
  Future<UserCredential> signInAnon() async {
    UserCredential result = await _auth.signInAnonymously();
    return result;
  }

  // email pass sign in
  Future<String> signInUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      }
    }
    // Successful sign in
    return '';
  }

  // new register
  Future<String> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    // Successful registration
    return '';
  }

  Future<void> signOut() async {
    await _auth.signOut();
    return;
  }
}
