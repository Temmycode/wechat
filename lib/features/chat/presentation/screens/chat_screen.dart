import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  late final WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _initializeWebsocket();
  }

  void _initializeWebsocket() async {
    final wsUrl = Uri.parse('ws/localhost:8000/ws/1');
    _channel = WebSocketChannel.connect(wsUrl);

    await _channel.ready;

    _channel.stream.listen((message) {
      _channel.sink.add('received!');
      _channel.sink.close(status.goingAway);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error, color: Colors.red));
                } else if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Text("Something sup1");
                }
              } else {
                return Text("Something sup2");
              }
            },
          ),
          TextField(controller: _messageController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }
}
