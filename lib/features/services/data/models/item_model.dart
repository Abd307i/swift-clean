import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

class ItemModel{
  final String id;
  final String itemName;
  final double subPrice;
  final int? count;
  final String? description;
  final String? imgUrl;

  const ItemModel({
    required this.id,
    required this.itemName,
    required this.subPrice,
    this.count,
    this.description,
    this.imgUrl
  });

  factory ItemModel.fromJson(Map<String, dynamic> json){
    return ItemModel(
        id: json['id'],
        itemName: json['itemName'],
        subPrice: json['subPrice'],
        count: json['count'],
        description: json['description'],
        imgUrl: json['imgUrl']
    );
  }


  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    return ItemModel(
        id: doc['id'],
        itemName: doc['itemName'],
        description: doc['description'],
        count: doc['count'],
        subPrice: doc['subPrice'],
        imgUrl: doc['imgUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'itemName': itemName,
      'description': description,
      'count':count,
      'subPrice': subPrice,
      'imgUrl': imgUrl
    };
  }

  ItemEntity toItemEntity() => ItemEntity(id: id, itemName: itemName, subPrice: subPrice, imgUrl: imgUrl, description: description, itemId: '',count:count);

}