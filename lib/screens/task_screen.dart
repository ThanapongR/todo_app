import 'dart:async';

import 'package:flutter/material.dart' hide AppBar;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_data.dart';
import 'package:todo_app/screens/lock_screen.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/appbar.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Timer? _inactivityTimer;

  Future<void> _loadLastActiveTime(BuildContext context2) async {
    final prefs = await SharedPreferences.getInstance();
    final lastActiveTimestamp = prefs.getInt('lastActiveTimestamp') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTimeInSeconds =
        ((currentTime - lastActiveTimestamp) / 1000).round();

    if (10 - elapsedTimeInSeconds <= 0) {
      if (context.mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LockScreen()),
        );
      }
    } else {
      _startInactivityTimer();
    }
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LockScreen()),
      );
    });
  }

  Future<void> _updateLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastActiveTimestamp', currentTime);
  }

  void _updateActivity() {
    _updateLastActiveTime();
    _startInactivityTimer();
  }

  @override
  void initState() {
    super.initState();
    _loadLastActiveTime(context);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100.0) {
        context.read<TaskData>().loadMoreItems();
      }
    });

    return Scaffold(
      body: Listener(
        child: CustomScrollView(
          controller: scrollController,
          slivers: const <Widget>[
            AppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            TaskList(),
            SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          ],
        ),
        onPointerDown: (_) {
          _updateActivity();
        },
        onPointerMove: (_) {
          _updateActivity();
        },
      ),
    );
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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

    if (context.read<TaskData>().taskStatus[0].tasks.isEmpty) {
      context.read<TaskData>().loadTasks(offset: 0, limit: 10);
    }
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
