import 'package:quickchance_app/conf/socketServices.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';

class NotificationSocketService {
  final socket = SocketService().socket;
  UserPreferences _userPreferences = UserPreferences();

  void joinNotification() async {
    var localUser = await _userPreferences.getLocalUser();
    String email = localUser!.email!;
    int userId = localUser.id;
    socket.emit('joinNotification', {'userId': userId, 'email': email});

    socket.on('joinedNotification', (data) {
      print('✅ Joined notification: $data');
    });
  }

  void getNotificationCount() async {
    var localUser = await _userPreferences.getLocalUser();
    String email = localUser!.email!;
    int userId = localUser.id;

    socket.emit('getNotificationCount', {'userId': userId, 'email': email});

    socket.on('countNotificationReply', (data) {
      print('notification count: $data');
    });
  }
}
