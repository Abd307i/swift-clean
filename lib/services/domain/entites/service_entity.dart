import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable{
  final String id;
  final String name;
  final String description;
  final String? imgUrl;

  const ServiceEntity({required this.id, required this.name, required this.description, this.imgUrl});

  @override
  List<Object?> get props => [id,name,description,imgUrl];

}