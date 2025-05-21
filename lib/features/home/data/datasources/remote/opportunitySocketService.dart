import 'package:quickchance_app/conf/appVariables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OpportunitySocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      Appvariables().homeUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print('Connected to WebSocket');
    });

    socket.onDisconnect((_) => print('Disconnected from WebSocket'));

    socket.on('onConnect', (data) {
      print('Server message: $data');
    });

    socket.on('joinedOpportunity', (data) {
      print('Joined room: ${data['opportunityId']}');
    });

    socket.on('countLikesReply', (data) {
      print('Like count: ${data['likeCount']}');
    });

    socket.on('error', (data) {
      print('Error: $data');
    });
  }

  void joinOpportunity(int opportunityId) {
    socket.emit('joinOpportunity', {'opportunityId': opportunityId});
  }

  void getLikeCount(int opportunityId) {
    socket.emit('getLikeCount', {'opportunityId': opportunityId});
  }

  void disconnect() {
    socket.disconnect();
  }
}
