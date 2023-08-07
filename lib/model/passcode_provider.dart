import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/task_screen.dart';

class PasscodeProvider extends ChangeNotifier {
  String _passcode = '';

  String get passcode => _passcode;

  Future<void> addPasscode(BuildContext context, String num) async {
    _passcode += num;

    if (_passcode.length >= 6) {
      if (_passcode == '123456') {
        await _updateLastActiveTime();
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TaskScreen()),
          );
        }
      }
      _passcode = '';
    }

    notifyListeners();
  }

  Future<void> _updateLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastActiveTimestamp', currentTime);
  }
}
