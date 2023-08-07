import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/task_screen.dart';

class PasscodeModel extends ChangeNotifier {
  String passcode = '';

  Future<void> addPasscode(BuildContext context, String num) async {
    passcode += num;

    if (passcode.length >= 6) {
      if (passcode == '123456') {
        final prefs = await SharedPreferences.getInstance();
        final currentTime = DateTime.now().millisecondsSinceEpoch;
        await prefs.setInt('lastActiveTimestamp', currentTime);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TaskScreen()),
          );
        }
      }
      passcode = '';
    }

    notifyListeners();
  }
}
