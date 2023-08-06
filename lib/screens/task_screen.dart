import 'package:flutter/material.dart' hide AppBar;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/appbar.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    Future<void> loadMoreItems() async {
      final TaskData taskData = Provider.of<TaskData>(context, listen: false);
      if (taskData.getLoading() == false) {
        int nextPage = taskData.getNextPage();
        if (nextPage >= 0) {
          taskData.setLoading(true);
          taskData.setCurrentPage(nextPage);
          taskData.loadTasks(offset: nextPage, limit: 10);
        }
      }
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100.0) {
        loadMoreItems();
      }
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: const <Widget>[
          AppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          TaskList(),
          SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
    context.read<TaskData>().loadTasks(offset: 0, limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    final TaskData taskData = Provider.of<TaskData>(context, listen: true);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final DateTime date = taskData.groupedTasks.keys.elementAt(index);
          final List<Task> tasks = taskData.groupedTasks[date] ?? [];

          List<Widget> taskWidget = [];
          for (Task task in tasks) {
            taskWidget.add(TaskTile(task: task));
          }

          return Container(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(date).toUpperCase(),
                  style: kTaskDateTextStyle,
                ),
                const SizedBox(height: 8.0),
                Column(
                  children: taskWidget,
                ),
              ],
            ),
          );
        },
        childCount: taskData.groupedTasks.length,
      ),
    );
  }
}
