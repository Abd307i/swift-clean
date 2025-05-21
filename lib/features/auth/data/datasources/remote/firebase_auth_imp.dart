import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/features/auth/data/datasources/remote/firebase_auth.dart';
import 'package:testing_firebase/features/auth/data/models/UserModel.dart';
import 'package:testing_firebase/features/auth/data/models/address_model.dart';
import 'package:testing_firebase/features/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/features/auth/domain/usecases/register_user.dart';

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

      if(params.userType == 'Customer') {
        await _firestore.collection('users').doc(user.user!.uid).set({
          'firstName': params.firstName,
          'lastName': params.lastName,
          'phone': params.phone,
          'email': params.email,
          'address': params.address,
          'createdAt': FieldValue.serverTimestamp(),
          'userType':'User',
          'verified': true
        });
      }else{
        await _firestore.collection('users').doc(user.user!.uid).set({
          'firstName': params.firstName,
          'lastName': params.lastName,
          'phone': params.phone,
          'email': params.email,
          'address': params.address,
          'createdAt': FieldValue.serverTimestamp(),
          'userType':params.userType,
          'verified': true
        });
      }
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
  Future<UserModel> getCurrentUser() async {
    try {
      final user = await _firestore.collection('users').where('email',isEqualTo: _firebaseAuth.currentUser?.email??"").get();
      final map = user.docs.first.data();
      map ['id'] = user.docs.first.id;
      map['emailVerified'] = _firebaseAuth.currentUser?.emailVerified == true;
      return UserModel.fromJson(map);
      //return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw (e.message ?? 'Failed to get current user');
    }
  }
}