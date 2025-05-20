import 'package:equatable/equatable.dart';

class OrderHistoryItemEntity extends Equatable {
  final String id;
  final String itemName;
  final double subPrice;
  final String? imgUrl;
  final String? description;
  

  OrderHistoryItemEntity({
    required this.id,
    required this.itemName,
    required this.subPrice,
    this.imgUrl,
    this.description
  });

  @override
  List<Object?> get props => [id,itemName,subPrice,imgUrl,description];
}