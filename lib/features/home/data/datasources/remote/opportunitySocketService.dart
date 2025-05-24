// import 'package:quickchance_app/conf/appVariables.dart';
// import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class OpportunitySocketService {
//   UserPreferences _userPreferences = UserPreferences();
//   late IO.Socket socket;

//   void connect() {
//     socket = IO.io(
//       Appvariables().homeUrl,
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .enableAutoConnect()
//           .build(),
//     );

//     socket.onConnect((_) {
//       print('Connected to WebSocket');
//     });

//     socket.onDisconnect((_) => print('Disconnected from WebSocket'));

//     socket.on('onConnect', (data) {
//       print('Server message: $data');
//     });

//     socket.on('joinedOpportunity', (data) {
//       print('Joined room: ${data['opportunityId']}');
//     });

//     socket.on('countLikesReply', (data) {
//       print('Like count: ${data['likeCount']}');
//     });

//     socket.on('checkLikesReply', (data) {
//       print('opp is liked: ${data['isLiked']}');
//     });

//     socket.on('error', (data) {
//       print('Error: $data');
//     });
//   }

//   void joinOpportunity(int opportunityId) async {
//     var localUser = await _userPreferences.getLocalUser();
//     int userId = localUser!.id;
//     socket.emit('joinOpportunity', {
//       'opportunityId': opportunityId,
//       'userId': userId,
//     });
//   }

//   void getLikeCount(int opportunityId) async {
//     var localUser = await _userPreferences.getLocalUser();
//     int userId = localUser!.id;
//     socket.emit('getLikeCount', {
//       'opportunityId': opportunityId,
//       'userId': userId,
//     });
//   }

//   void checkIfLiked(int opportunityId) async {
//     var localUser = await _userPreferences.getLocalUser();
//     int userId = localUser!.id;
//     socket.emit('checkIfLiked', {
//       'opportunityId': opportunityId,
//       'userId': userId,
//     });
//   }

//   void disconnect() {
//     socket.disconnect();
//   }
// }

import 'package:quickchance_app/conf/socketServices.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';

class OpportunitySocketService {
  final socket = SocketService().socket;
  UserPreferences _userPreferences = UserPreferences();

  void joinOpportunity(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('joinOpportunity', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('joinedOpportunity', (data) {
      print('✅ Joined opportunity: $data');
    });
  }

  void getLikeCount(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('getLikeCount', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('countLikesReply', (data) {
      print('liked opportunity: $data');
    });
  }

  void checkIfLiked(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('checkIfLiked', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('checkLikesReply', (data) {
      print('👍 Liked: ${data['isLiked']}');
    });
  }

  void getCommentCount(int opportunityId) async {
    var localUser = await _userPreferences.getLocalUser();
    int userId = localUser!.id;
    socket.emit('getCommentCount', {
      'opportunityId': opportunityId,
      'userId': userId,
    });

    socket.on('countCommentReply', (data) {
      print('opportunity comment: $data');
    });
  }
}
