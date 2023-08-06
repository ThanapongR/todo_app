import 'package:flutter/material.dart';
import 'package:todo_app/utilities/constants.dart';

class TaskBadge extends StatelessWidget {
  const TaskBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: kGreyColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            selected: true,
            title: 'To-do',
          ),
          SizedBox(
            width: 8.0,
          ),
          Badge(
            selected: false,
            title: 'Doing',
          ),
          SizedBox(
            width: 8.0,
          ),
          Badge(
            selected: false,
            title: 'Done',
          ),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final bool selected;
  final String title;

  const Badge({
    super.key,
    required this.selected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 4.0,
        right: 12.0,
        bottom: 4.0,
      ),
      decoration: selected
          ? BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF86CAF6), Color(0xFFA1A5E8)],
              ),
              borderRadius: BorderRadius.circular(32.0),
            )
          : BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.circular(32.0),
            ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: selected ? Colors.white : Colors.black26,
        ),
      ),
    );
  }
}
