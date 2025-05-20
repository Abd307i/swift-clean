import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable{
  final String id;
  final String itemName;
  final String itemId;
  final double subPrice;
  final int? count;
  final String? imgUrl;
  final String? description;

  ItemEntity({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.subPrice,
    this.imgUrl,
    this.count,
    this.description
});

  @override
  List<Object?> get props => [id,itemName,subPrice,imgUrl,count,description];

}