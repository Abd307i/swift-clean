
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';
import 'package:testing_firebase/features/notification/domain/repositories/notification_repository.dart';
import 'package:testing_firebase/features/notification/domain/usecases/usecase.dart';

import '../../data/repositories/notification_repository_imp.dart';

class GetNotifications implements UseCase<List<NotificationEntity>, String>{
  final NotificationRepository repository;

  const GetNotifications(this.repository);

  @override
  Future<List<NotificationEntity>> call(String userId) async {
    return await repository.getNotifications(userId);
  }

}