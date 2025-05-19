
import 'package:testing_firebase/features/auth/data/models/UserModel.dart';
import 'package:testing_firebase/features/user%20type/data/datasources/remote/user_type_datasource.dart';
import '../models/shop_model.dart';

// Custom result class to handle success or failure
class Result<T> {
  final T? data;
  final Exception? error;
  final bool isSuccess;

  Result.success(this.data) : error = null, isSuccess = true;
  Result.failure(this.error) : data = null, isSuccess = false;
}

abstract class UserTypeRepository {
  Future<Result<void>> createUser(UserModel user);
  Future<Result<UserModel>> getCurrentUser();
  Future<Result<List<String>>> getUserTypes();
  Future<Result<void>> createShop(ShopModel shop);
  Future<Result<ShopModel?>> getShopByOwner(String ownerId);
}

class UserTypeRepositoryImpl implements UserTypeRepository {
  final UserTypeDataSource _dataSource;

  UserTypeRepositoryImpl(this._dataSource);

  @override
  Future<Result<void>> createUser(UserModel user) async {
    try {
      await _dataSource.createUser(user);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('Repository Error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return Result.success(user);
    } catch (e) {
      return Result.failure(Exception('Repository Error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<String>>> getUserTypes() async {
    try {
      final types = await _dataSource.getUserTypes();
      return Result.success(types);
    } catch (e) {
      return Result.failure(Exception('Repository Error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> createShop(ShopModel shop) async {
    try {
      await _dataSource.createShop(shop);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('Repository Error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<ShopModel?>> getShopByOwner(String ownerId) async {
    try {
      final shop = await _dataSource.getShopByOwner(ownerId);
      return Result.success(shop);
    } catch (e) {
      return Result.failure(Exception('Repository Error: ${e.toString()}'));
    }
  }
}