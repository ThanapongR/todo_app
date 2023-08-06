import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/utilities/constants.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
    );
  }
}
