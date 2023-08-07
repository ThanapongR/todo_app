import 'package:flutter/foundation.dart';

class PasscodeModel extends ChangeNotifier {
  String passcode = '';

  void addPasscode(String num) {
    passcode += num;
    notifyListeners();
  }

  void clear() {
    passcode = '';
    notifyListeners();
  }
}
