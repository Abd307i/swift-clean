import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/service_entity.dart';

class ServiceModel{
  final String id;
  final String name;
  final String description;

  ServiceModel({required this.id, required this.name, required this.description});

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    return ServiceModel(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
    );
  }
  ServiceEntity toEntity() => ServiceEntity(id: id, name: name, description: description);
}