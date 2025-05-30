import 'package:quickchance_app/features/notifications/data/datasources/remote/notificationApiService.dart';
import 'package:quickchance_app/features/notifications/data/models/userNotification.dart';
import 'package:quickchance_app/features/notifications/domain/repository/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  @override
  Future<List<UserNotification>> fetchAllUserNotifications() async {
    return await NotificationApiService().fetchAllUserNotification();
  }
}
