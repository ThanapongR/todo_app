import 'package:flutter/material.dart' hide AppBar;
import 'package:intl/intl.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/appbar.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final ScrollController _scrollController = ScrollController();
  final TaskData _todo = TaskData();

  void loadItems() {
    _todo.getTasksList(offset: 0, limit: 10).then((data) {
      setState(() {
        _todo.add(data['tasks']);
        _todo.setTotalPages(data['totalPages']);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    loadItems();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100.0) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_todo.isLoading == false) {
      int nextPage = _todo.getNextPage();
      if (nextPage >= 0) {
        _todo.isLoading = true;
        _todo.setCurrentPage(nextPage);
        final dynamic data = await _todo.getTasksList(
          offset: nextPage,
          limit: 10,
        );

        setState(() {
          _todo.add(data['tasks']);
          _todo.setTotalPages(data['totalPages']);
        });

        Future.delayed(const Duration(milliseconds: 10), () {
          _todo.isLoading = false; // Reset the flag after loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = _todo.getGroupedTasks();

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          const AppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          TaskList(task: task),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.task,
  });

  final Map<DateTime, List<Task>> task;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final date = task.keys.elementAt(index);
        final tasks = task[date]!;

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
              const SizedBox(
                height: 8.0,
              ),
              Column(
                children: taskWidget,
              )
            ],
          ),
        );
      },
      childCount: task.length,
    ));
  }
}
