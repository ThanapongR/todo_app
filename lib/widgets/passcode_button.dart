import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/passcode_model.dart';
import 'package:todo_app/screens/task_screen.dart';
import 'package:todo_app/utilities/constants.dart';

class PassCodeButton extends StatelessWidget {
  final String title;

  const PassCodeButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 72.0,
      height: 72.0,
      decoration: const BoxDecoration(
        color: kGreyColor,
        shape: BoxShape.circle,
      ), // LinearGradientBoxDecoration
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.black54,
            ),
          ),
        ),
        onTap: () async {
          final PasscodeModel passcodeData =
              Provider.of<PasscodeModel>(context, listen: false);
          passcodeData.addPasscode(title);

          String passcode = passcodeData.passcode;
          if (passcode.length >= 6) {
            passcodeData.clear();
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
          }
        },
      ), // Red will correctly spread over gradient
    );
  }
}
