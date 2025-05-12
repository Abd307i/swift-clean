import 'package:testing_firebase/notification/domain/repositories/notification_repository.dart';
import 'package:testing_firebase/notification/domain/usecases/usecase.dart';

class ToggleMuteNotification implements UseCase<void, bool>{
  final NotificationRepository repository;

  ToggleMuteNotification(this.repository);

  @override
  Future<void> call(bool isMuted) async {
    return await repository.toggleMuteNotifications(isMuted);
  }

}