import 'package:testing_firebase/features/notification/domain/repositories/notification_repository.dart';
import 'package:testing_firebase/features/notification/domain/usecases/usecase.dart';

class MarkAsRead implements UseCase<void, String>{
  final NotificationRepository repository;

  MarkAsRead(this.repository);

  @override
  Future<void> call(String notificationId) async{
    return await repository.markAsRead(notificationId);
  }

}