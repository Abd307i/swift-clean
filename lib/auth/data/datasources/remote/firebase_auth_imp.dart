import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth.dart';
import 'package:testing_firebase/auth/data/models/address_model.dart';
import 'package:testing_firebase/auth/domain/usecases/register_user.dart';

class FirebaseAuthImp implements FirebaseAuthi{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthImp(this._firebaseAuth, this._firestore);

  @override
  Future<UserCredential> loginUser(String username, String password) async{
    try{
      return await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Login failed');
    }
  }

  @override
  Future<UserCredential> registerUser(RegisterUserParams params) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      await _firestore.collection('users').doc(user.user!.uid).set({
        'firstName':params.firstName,
        'lastName':params.lastName,
        'phone': params.phone,
        'address': AddressModel(
          street: params.address?.street,
          city: params.address?.city,
          postalCode: params.address?.postalCode,
          lat: params.address?.lat,
          lng: params.address?.lng,
        ).toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return user;
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Registration failed');
    } catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> forgotPassword(String username) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: username);
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Password reset failed');
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
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Failed to get current user');
    }
  }
}