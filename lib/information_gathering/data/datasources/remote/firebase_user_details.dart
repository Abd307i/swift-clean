import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/information_gathering/data/models/user_info_model.dart';


abstract class InfoGatheringDataSource {
  Future<void> saveUserInfo(UserInfoModel userInfo);
  Future<UserInfoModel> getUserInfo(String userId);
  Future<void> updateUserInfo(UserInfoModel userInfo);
}

class InfoGatheringDataSourceImpl implements InfoGatheringDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  InfoGatheringDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  @override
  Future<void> saveUserInfo(UserInfoModel userInfo) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final updatedUserInfo = UserInfoModel(
        userId: userInfo.userId,
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        phone: userInfo.phone,
        address: userInfo.address,
        email: currentUser.email, // Automatically set from Firebase Auth
        createdAt: Timestamp.now(), // Automatically set to current time
      );

      await _firestore.collection('Users').doc(userInfo.userId).set(
            updatedUserInfo.toJson(),
            SetOptions(merge: true), // Merge to avoid overwriting other fields
          );
    } catch (e) {
      throw Exception('Failed to save user info: $e');
    }
  }

  @override
  Future<UserInfoModel> getUserInfo(String userId) async {
    try {
      final doc = await _firestore.collection('Users').doc(userId).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserInfoModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to retrieve user info: $e');
    }
  }

  @override
  Future<void> updateUserInfo(UserInfoModel userInfo) async {
    try {
      await _firestore.collection('Users').doc(userInfo.userId).update(
            userInfo.toJson(),
          );
    } catch (e) {
      throw Exception('Failed to update user info: $e');
    }
  }
}