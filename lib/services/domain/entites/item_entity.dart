import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable{
  final String id;
  final String serviceId;
  final String name;
  final double price;
  final String? imgUrl;

  ItemEntity({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.price,
    this.imgUrl
});

  @override
  List<Object?> get props => [id,serviceId,name,price,imgUrl];

}