import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth.dart';

class AuthRemoteDataSourceImpl  implements AuthRemoteDataSource{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth, required FirebaseFirestore firestore}):
      _firebaseAuth = firebaseAuth, _firestore = firestore;

  @override
  Future<void> loginUser(String username, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Login failed');
    } catch (e){
      throw e.toString();
    }
  }

  @override
  Future<void> registerUser(String username, String password, String firstName, String lastName, String phoneNumber) async {
    try {
      final userCredential  = await _firebaseAuth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential .user?.uid).set({
          'firstName':firstName,
          'lastName':lastName,
          'email': username,
          'phone': phoneNumber,
          'createdAt':FieldValue.serverTimestamp(),
        });
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Registration failed');
    } catch (e){
      throw e.toString();
    }
  }

  @override
  Future<void> forgotPassword(String username) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: username);
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Password reset failed');
    } catch (e){
      e.toString();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Failed to send verification email');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Logout failed');
    } catch (e){
      e.toString();
    }
  }

  @override
  Stream <User?> get authStateChanges => _firebaseAuth.authStateChanges();
}