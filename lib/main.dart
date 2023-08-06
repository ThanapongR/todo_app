import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/passcode_data.dart';
import 'package:todo_app/model/task_data.dart';
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
        ChangeNotifierProvider(create: (context) => TaskData()),
        ChangeNotifierProvider(create: (context) => PasscodeData()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        home: TaskScreen(),
      ),
    );
  }
}
