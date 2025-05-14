import 'package:testing_firebase/features/services/domain/repositories/cart_repository.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String itemId) async {
    if (itemId.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.removeFromCart(itemId);
  }
}