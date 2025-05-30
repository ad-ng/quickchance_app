import 'package:quickchance_app/features/notifications/data/models/userNotification.dart';

abstract class NotificationRepo {
  Future<List<UserNotification>> fetchAllUserNotifications();
}
