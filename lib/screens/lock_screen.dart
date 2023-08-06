import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/screens/task_screen.dart';

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
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            ObscureIcons(),
            PassCodeKeypad()
          ],
        ),
      ),
    );
  }
}

class ObscureIcons extends StatelessWidget {
  const ObscureIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 192.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ObscureIcon(
            checked: true,
          ),
          SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: true,
          ),
          SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: false,
          ),
          SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: false,
          ),
          SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: false,
          ),
          SizedBox(
            width: 16.0,
          ),
          ObscureIcon(
            checked: false,
          ),
        ],
      ),
    );
  }
}

class ObscureIcon extends StatelessWidget {
  final bool checked;

  const ObscureIcon({
    super.key,
    required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: checked ? Colors.black38 : const Color(0xFFDFE0E5),
        shape: BoxShape.circle,
      ),
    );
  }
}

class PassCodeKeypad extends StatelessWidget {
  const PassCodeKeypad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        color: Color(0xFFDFE0E5),
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
        onTap: () {
          print(Provider.of<TaskData>(context, listen: false)
              .taskStatus[0]
              .tasks
              .length);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TaskScreen()),
          );
        },
      ), // Red will correctly spread over gradient
    );
  }
}
