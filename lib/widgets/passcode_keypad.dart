import 'package:flutter/material.dart';
import 'package:todo_app/widgets/passcode_button.dart';

class PassCodeKeypad extends StatelessWidget {
  const PassCodeKeypad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PassCodeButton(
              title: '1',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '2',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '3',
            ),
          ],
        ),
        SizedBox(
          height: 32.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PassCodeButton(
              title: '4',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '5',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '6',
            ),
          ],
        ),
        SizedBox(
          height: 32.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PassCodeButton(
              title: '7',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '8',
            ),
            SizedBox(
              width: 32.0,
            ),
            PassCodeButton(
              title: '9',
            ),
          ],
        ),
        SizedBox(
          height: 32.0,
        ),
        PassCodeButton(
          title: '0',
        ),
      ],
    );
  }
}
