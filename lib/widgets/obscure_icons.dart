import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/passcode_model.dart';
import 'package:todo_app/widgets/obscure_icon.dart';

class ObscureIcons extends StatelessWidget {
  const ObscureIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PasscodeModel passcodeData =
        Provider.of<PasscodeModel>(context, listen: true);
    int length = passcodeData.passcode.length;
    return SizedBox(
      height: 192.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ObscureIcon(
            checked: length >= 1,
          ),
          const SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: length >= 2,
          ),
          const SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: length >= 3,
          ),
          const SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: length >= 4,
          ),
          const SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: length >= 5,
          ),
          const SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: length >= 6,
          ),
        ],
      ),
    );
  }
}
