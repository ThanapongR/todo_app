import 'package:flutter/material.dart';
import 'package:todo_app/screens/lock_screen.dart';
import 'package:todo_app/screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      home: TaskScreen(),
    );
  }
}
