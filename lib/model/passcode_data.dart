import 'package:flutter/foundation.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_status.dart';
import 'package:todo_app/services/networking.dart';

class PasscodeData extends ChangeNotifier {
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
