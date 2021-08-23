import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User> authStateChanges();
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAtuth = FirebaseAuth.instance;
  @override
  Stream<User> authStateChanges() => _firebaseAtuth.authStateChanges();
  @override
  User get currentUser => _firebaseAtuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final UserCredential = await _firebaseAtuth.signInAnonymously();
    return UserCredential.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential = await _firebaseAtuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return UserCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential = await _firebaseAtuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAtuth.signOut();
  }
}
