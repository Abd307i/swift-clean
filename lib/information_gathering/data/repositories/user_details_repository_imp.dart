import 'package:testing_firebase/information_gathering/data/datasources/remote/firebase_user_details.dart';
import 'package:testing_firebase/information_gathering/data/models/user_info_model.dart';

abstract class InfoGatheringRepository {
  Future<void> saveUserInfo(UserInfoModel userInfo);
  Future<UserInfoModel> getUserInfo(String userId);
  Future<void> updateUserInfo(UserInfoModel userInfo);
}

class InfoGatheringRepositoryImpl implements InfoGatheringRepository {
  final InfoGatheringDataSource dataSource;

  InfoGatheringRepositoryImpl({required this.dataSource});

  @override
  Future<void> saveUserInfo(UserInfoModel userInfo) async {
    try {
      await dataSource.saveUserInfo(userInfo);
    } catch (e) {
      throw Exception('Failed to save user info: $e');
    }
  }

  @override
  Future<UserInfoModel> getUserInfo(String userId) async {
    try {
      return await dataSource.getUserInfo(userId);
    } catch (e) {
      throw Exception('Failed to retrieve user info: $e');
    }
  }

  @override
  Future<void> updateUserInfo(UserInfoModel userInfo) async {
    try {
      await dataSource.updateUserInfo(userInfo);
    } catch (e) {
      throw Exception('Failed to update user info: $e');
    }
  }
}