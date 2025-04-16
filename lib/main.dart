import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Agent Chat',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ChatScreen(),
    );
  }
}
