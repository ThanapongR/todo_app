import 'package:flutter/material.dart';
import 'package:todo_app/utilities/constants.dart';

class ObscureIcon extends StatelessWidget {
  final bool checked;

  const ObscureIcon({super.key, required this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: checked ? Colors.black38 : kDarkGreyColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
