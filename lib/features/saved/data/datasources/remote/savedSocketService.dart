import 'package:quickchance_app/conf/socketServices.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';

class SavedSocketService {
  final socket = SocketService().socket;
  UserPreferences _userPreferences = UserPreferences();

  void getSavedCount(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('getSavedCount', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('countSavedReply', (data) {
      print('saved opportunity: $data');
    });
  }

  void checkIfSaved(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('checkIfSaved', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('checkSavedReply', (data) {
      print('👍 Saved: $data');
    });
  }
}
