// 1. DATA LAYER STRUCTURE FOR USER TYPE FEATURE

// 1.1. Data Sources - user_type_datasource.dart
// This file handles the direct communication with Firebase

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/features/auth/data/models/UserModel.dart';
import 'package:testing_firebase/features/user%20type/data/models/shop_model.dart';


abstract class UserTypeDataSource {
  Future<void> createUser(UserModel user);
  Future<UserModel> getCurrentUser();
  Future<List<String>> getUserTypes();
  Future<void> createShop(ShopModel shop);
  Future<ShopModel?> getShopByOwner(String ownerId);
}

class UserTypeDataSourceImpl implements UserTypeDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserTypeDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently logged in');
      }

      final userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      return UserModel.fromJson(userDoc.data()!, userDoc.id);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<List<String>> getUserTypes() async {
   
    return ['customer', 'dry_cleaner', 'delivery'];
  }

  @override
  Future<void> createShop(ShopModel shop) async {
    try {
      await _firestore
          .collection('shops')
          .doc()
          .set(shop.toJson());
    } catch (e) {
      throw Exception('Failed to create shop: $e');
    }
  }

  @override
  Future<ShopModel?> getShopByOwner(String ownerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('shops')
          .where('ownerId', isEqualTo: ownerId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final shopDoc = querySnapshot.docs.first;
      return ShopModel.fromJson(shopDoc.data(), shopDoc.id);
    } catch (e) {
      throw Exception('Failed to get shop for owner: $e');
    }
  }
}