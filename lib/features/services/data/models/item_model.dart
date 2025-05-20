import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

class ItemModel{
  final String id;
  final String itemName;
  final String? itemId;
  final double subPrice;
  final int? count;
  final String? description;
  final String? imgUrl;

  const ItemModel({
    required this.id,
    required this.itemName,
    required this.subPrice,
    this.count,
    this.itemId,
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
        imgUrl: json['imgUrl'],
      itemId: json['itemId']
    );
  }


  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    return ItemModel(
        id: doc['id'],
        itemName: doc['itemName'],
        description: doc['description'],
        count: doc['count'],
        subPrice: doc['subPrice'],
        imgUrl: doc['imgUrl'],
        itemId: doc['itemId']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'itemName': itemName,
      'description': description,
      'count':count,
      'subPrice': subPrice,
      'imgUrl': imgUrl,
      'itemId':itemId
    };
  }

  ItemEntity toItemEntity() => ItemEntity(id: id??'a', itemName: itemName, subPrice: subPrice, imgUrl: imgUrl??'b', description: description??'c', itemId: itemId??'d',count:count);

}