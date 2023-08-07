import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskModel taskDataRead = context.read<TaskModel>();
    if (taskDataRead.taskStatus[0].tasks.isEmpty) {
      taskDataRead.loadTasks(offset: 0, limit: 10);
    }

    final TaskModel taskData = Provider.of<TaskModel>(context, listen: true);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final DateTime date = taskData.groupedTasks.keys.elementAt(index);
          final List<Task> tasks = taskData.groupedTasks[date] ?? [];

          List<Widget> taskWidget = [];
          for (Task task in tasks) {
            taskWidget.add(TaskTile(task: task));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 32.0),
                child: Text(
                  DateFormat('dd MMM yyyy').format(date).toUpperCase(),
                  style: kTaskDateTextStyle,
                ),
              ),
              const SizedBox(height: 8.0),
              Column(
                children: taskWidget,
              ),
            ],
          );
        },
        childCount: taskData.groupedTasks.length,
      ),
    );
  }
}
