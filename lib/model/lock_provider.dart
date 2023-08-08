import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/passcode_screen.dart';
import 'package:todo_app/utilities/constants.dart';

class LockProvider extends ChangeNotifier {
  Timer? _inactivityTimer;

  void _navigateToLockScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LockScreen()),
    );
  }

  Future<void> _startInactivityTimer(BuildContext context) async {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: kLockTime), () {
      _navigateToLockScreen(context);
    });
  }

  Future<void> loadLastActiveTime(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastActiveTimestamp = prefs.getInt('lastActiveTimestamp') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTimeInSeconds =
        ((currentTime - lastActiveTimestamp) / 1000).round();

    if (kLockTime - elapsedTimeInSeconds <= 0) {
      if (context.mounted) {
        _navigateToLockScreen(context);
      }
    } else {
      if (context.mounted) {
        _startInactivityTimer(context);
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
    _startInactivityTimer(context);
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }
}
