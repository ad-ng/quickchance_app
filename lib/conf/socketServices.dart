import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:quickchance_app/conf/appVariables.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  SocketService._internal();

  late IO.Socket _socket;
  bool _isConnected = false;

  IO.Socket get socket => _socket;

  void connect() {
    if (_isConnected) return;

    _socket = IO.io(
      Appvariables().homeUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      _isConnected = true;
      print('✅ Connected to WebSocket');
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      print('❌ Disconnected from WebSocket');
    });

    _socket.on('error', (data) {
      print('⚠️ Socket error: $data');
    });
  }

  void disconnect() {
    if (_isConnected) {
      _socket.disconnect();
      _isConnected = false;
    }
  }
}
