import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/utilities/constants.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (_) {
        context.read<TaskModel>().removeTask(task.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 32.0, bottom: 16.0, right: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_activity,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: kTaskTitleTextStyle,
                  ),
                  Text(
                    task.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: kTaskDescTextStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.more_vert,
              color: Colors.black54,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
