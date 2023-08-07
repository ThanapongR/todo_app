import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/lock_provider.dart';
import 'package:todo_app/model/passcode_provider.dart';
import 'package:todo_app/model/scroll_controller_provider.dart';
import 'package:todo_app/model/task_provider.dart';
import 'package:todo_app/screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ScrollControllerProvider()),
        ChangeNotifierProvider(create: (context) => PasscodeProvider()),
        ChangeNotifierProvider(create: (context) => LockProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        home: TaskScreen(),
      ),
    );
  }
}
