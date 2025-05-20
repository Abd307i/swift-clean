import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

class ItemModel{
  final String id;
  final String itemName;
  final double subPrice;
  final String serviceId;
  final int? count;
  final String? description;
  final String? imgUrl;

  const ItemModel({
    required this.id,
    required this.itemName,
    required this.subPrice,
    required this.serviceId,
    this.description,
    this.count,
    this.imgUrl
});

  factory ItemModel.fromJson(Map<String, dynamic> json){
    return ItemModel(
        id: json['id'],
        itemName: json['itemName'],
        subPrice: json['subPrice'],
        serviceId: json['serviceId'],
        count: json['count']
    );
  }


  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    return ItemModel(
      id: doc['id'],
      itemName: doc['itemName'],
      subPrice: doc['subPrice'],
      serviceId: doc['serviceId'],
      count: doc['count']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'itemName': itemName,
      'serviceId':serviceId,
      'subPrice': subPrice,
      'count':count
    };
  }

  ItemEntity toItemEntity() => ItemEntity(id: id,itemId:  serviceId ,itemName: itemName, subPrice: subPrice, imgUrl: imgUrl, description: description);

}