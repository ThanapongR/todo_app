import 'package:flutter/material.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/obscure_icons.dart';
import 'package:todo_app/widgets/passcode_keypad.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFECEDFD),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your passcode',
              style: kPasscodeTitleTextStyle,
            ),
            ObscureIcons(),
            PassCodeKeypad()
          ],
        ),
      ),
    );
  }
}
