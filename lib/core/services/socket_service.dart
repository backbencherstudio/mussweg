import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  final _messageController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messageStream => _messageController.stream;

  Future<void> connect(String token) async {
    socket = IO.io(
      "http://192.168.7.14:5005",
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .setExtraHeaders({"Authorization": "Bearer $token"})
          .enableReconnection()
          .enableForceNew()
          .build(),
    );

    socket!.onConnect((_) {
      print(" SOCKET CONNECTED: ${socket!.id}");
    });

    socket!.onDisconnect((_) {
      print(" SOCKET DISCONNECTED");
    });

    socket!.on("message", (data) {
      print(" SOCKET MESSAGE → $data");
      _messageController.add(data);
    });
  }

  void joinRoom(String roomId) {
    socket?.emit("joinroom", {"room_id": roomId});
  }

  void sendMessage({required String to, required Map<String, dynamic> data}) {
    socket?.emit("sendMessage", {"to": to, "data": data});
  }

  void dispose() {
    socket?.dispose();
    _messageController.close();
  }
}
