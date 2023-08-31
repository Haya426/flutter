import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageStream = Stream<Message>.periodic(
    Duration(seconds: 2),
    (count) => Message(
      sender: 'User $count',
      text: 'Hello from user $count!',
    ),
  ).take(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App')),
      body: Center(
        child: StreamBuilder<Message>(
          stream: _messageStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final message = snapshot.data!;
              return ListTile(
                title: Text(message.sender),
                subtitle: Text(message.text),
              );
            } else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}
