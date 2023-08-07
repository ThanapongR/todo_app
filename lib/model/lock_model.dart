import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/passcode_screen.dart';

class LockModel extends ChangeNotifier {
  Timer? inactivityTimer;

  void startInactivityTimer(BuildContext context) {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LockScreen()),
      );
    });
  }

  Future<void> loadLastActiveTime(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastActiveTimestamp = prefs.getInt('lastActiveTimestamp') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTimeInSeconds =
        ((currentTime - lastActiveTimestamp) / 1000).round();

    if (10 - elapsedTimeInSeconds <= 0) {
      if (context.mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LockScreen()),
        );
      }
    } else {
      if (context.mounted) {
        startInactivityTimer(context);
      }
    }
  }

  Future<void> updateLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastActiveTimestamp', currentTime);
  }

  void updateActivity(BuildContext context) {
    updateLastActiveTime();
    startInactivityTimer(context);
  }

  @override
  void dispose() {
    inactivityTimer?.cancel();
    super.dispose();
  }
}
