import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

class ItemModel{
  final String id;
  final String serviceId;
  final String name;
  final double price;
  final String description;
  final String? imgUrl;

  const ItemModel({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.price,
    required this.description,
    this.imgUrl
});

  factory ItemModel.fromJson(Map<String, dynamic> json){
    return ItemModel(id: json['id'],
        serviceId: json['serviceId'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        imgUrl: json['imgUrl']
    );
  }
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    return ItemModel(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      serviceId: doc['serviceId'],
      price: doc['price'],
      imgUrl: doc['imgUrl']
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

  ItemEntity toItemEntity() => ItemEntity(id: id, serviceId: serviceId, name: name, price: price,imgUrl: imgUrl, description:description);

}