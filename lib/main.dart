import 'package:flutter/material.dart';
import 'package:todo_app/screens/lock_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      home: const LockScreen(),
    );
  }
}
