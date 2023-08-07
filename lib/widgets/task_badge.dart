import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/scroll_controller_provider.dart';
import 'package:todo_app/model/task_provider.dart';
import 'package:todo_app/utilities/constants.dart';

class TaskBadge extends StatelessWidget {
  const TaskBadge({super.key});

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
          Badge(title: 'To-do', index: 0),
          SizedBox(width: 8.0),
          Badge(title: 'Doing', index: 1),
          SizedBox(width: 8.0),
          Badge(title: 'Done', index: 2),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String title;
  final int index;

  const Badge({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    TaskProvider taskData = Provider.of<TaskProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 4.0,
        right: 12.0,
        bottom: 4.0,
      ),
      decoration: taskData.getStatus() == index
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
      child: InkWell(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color:
                taskData.getStatus() == index ? Colors.white : Colors.black26,
          ),
        ),
        onTap: () {
          context.read<ScrollControllerProvider>().resetScrollOffset();
          context.read<TaskProvider>().changeStatus(index);
        },
      ),
    );
  }
}
