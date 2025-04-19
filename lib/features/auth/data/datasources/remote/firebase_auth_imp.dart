import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth.dart';

class FirebaseAuthImp implements FirebaseAuthi{
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthImp(this._firebaseAuth);

  @override
  Future<UserCredential> loginUser(String username, String password) async{
    try{
      return await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch(e){
      throw e.toString();
    }
  }

  @override
  Future<UserCredential> registerUser(String username, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> forgotPassword(String username) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: username);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }
}