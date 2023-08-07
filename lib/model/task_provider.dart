import 'package:flutter/foundation.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_status.dart';
import 'package:todo_app/services/networking.dart';

const tasksListURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

class TaskProvider extends ChangeNotifier {
  Map<DateTime, List<Task>> groupedTasks = {};
  int _status = 0;

  List<TaskStatus> taskStatus =
      List<TaskStatus>.generate(3, (_) => TaskStatus(tasks: []));

  int getStatus() => _status;

  Future<void> loadTasks({required int offset, required int limit}) async {
    taskStatus[_status].loading = true;
    taskStatus[_status].currentPage = offset;

    final data = await _getTasksList(offset: offset, limit: limit);

    _updateTaskStatus(data);

    _genGroupedTasks();

    Future.delayed(const Duration(milliseconds: 20), () {
      taskStatus[_status].loading = false; // Reset the flag after
    });

    notifyListeners();
  }

  Future<Map<String, dynamic>> _getTasksList(
      {required int offset, required int limit}) async {
    List<String> statusValues = ['TODO', 'DOING', 'DONE'];
    String status = statusValues[_status];

    Uri url = Uri.parse(
        '$tasksListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=$status');
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic tasksList = await networkHelper.getData();

    return tasksList;
  }

  void _updateTaskStatus(Map<String, dynamic> data) {
    final tasks = data['tasks'] as List<dynamic>? ?? [];

    for (final d in tasks) {
      final task = Task(
        id: d['id'] ?? '',
        title: d['title'] ?? '',
        description: d['description'] ?? '',
        createdAt: DateTime.tryParse(d['createdAt'] ?? '') ?? DateTime.now(),
        status: d['status'] ?? '',
      );

      if (!taskStatus[_status].tasks.any((obj) => obj.id == task.id)) {
        taskStatus[_status].tasks.add(task);
      }
    }

    taskStatus[_status].totalPages = (data['totalPages'] ?? 1) - 1;
  }

  void _genGroupedTasks() {
    groupedTasks.clear();
    for (Task task in taskStatus[_status].tasks) {
      DateTime dateTime = DateTime(
          task.createdAt.year, task.createdAt.month, task.createdAt.day);
      groupedTasks.putIfAbsent(dateTime, () => []).add(task);
    }
  }

  int _getNextPage() {
    final nextPage = taskStatus[_status].currentPage + 1;
    return nextPage <= taskStatus[_status].totalPages ? nextPage : -1;
  }

  Future<void> loadMoreItems() async {
    if (!taskStatus[_status].loading) {
      int nextPage = _getNextPage();
      if (nextPage >= 0) {
        loadTasks(offset: nextPage, limit: 10);
      }
    }
  }

  void changeStatus(int status) {
    _status = status;
    if (taskStatus[_status].currentPage == -1) {
      loadTasks(offset: 0, limit: 10);
    } else {
      _genGroupedTasks();
    }
    notifyListeners();
  }

  void removeTask(String id) {
    taskStatus[_status].tasks.removeWhere((task) => task.id == id);
    _genGroupedTasks();
    notifyListeners();
  }
}
