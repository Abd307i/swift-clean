import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class GetCartTotalPrice {
  final ServiceRepository repository;

  GetCartTotalPrice(this.repository);

  Future<double> call(String userId) async {
    return await repository.getCartTotalPrice(userId);
  }
}