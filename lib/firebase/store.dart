import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  Future<UserCredential> signUp(String myemail, String mypassword) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: myemail, password: mypassword);
    return authResult;
  }

  Future<UserCredential> signIn(String myemail, String mypassword) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: myemail, password: mypassword);
    return authResult;
  }
}
