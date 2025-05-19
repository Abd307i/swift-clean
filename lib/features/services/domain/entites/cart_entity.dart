import 'package:equatable/equatable.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

class CartEntity extends Equatable{
  final List<ItemEntity> items;
  final double totalPrice;

  CartEntity({
    required this.items,
    required this.totalPrice
  });

  @override
  List<Object?> get props => [items,totalPrice];

}