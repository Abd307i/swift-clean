import 'package:testing_firebase/services/domain/entites/item_entity.dart';

class ItemModel{
  final String id;
  final String serviceId;
  final String name;
  final double price;
  final String? imgUrl;

  const ItemModel({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.price,
    this.imgUrl
});

  factory ItemModel.fromJson(Map<String, dynamic> json){
    return ItemModel(id: json['id'],
        serviceId: json['serviceId'],
        name: json['name'],
        price: json['price'],
        imgUrl: json['imgUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'serviceId':serviceId,
      'name': name,
      'price': price,
      'imgUrl': imgUrl
    };
  }

  ItemEntity toItemEntity() => ItemEntity(id: id, serviceId: serviceId, name: name, price: price,imgUrl: imgUrl);

}