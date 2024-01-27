import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final IO.Socket _socket =
      IO.io("uri", IO.OptionBuilder().setTransports(['websocket']).build());

  _connectSocket() {
    _socket.onConnect((data) => print("Connection established"));
    _socket.onConnectError((data) => print("Connect error: $data"));
    _socket.onDisconnect((data) => print("Server disconnected"));
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("hello chat");
  }
}
