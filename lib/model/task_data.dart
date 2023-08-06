import 'package:flutter/foundation.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_status.dart';
import 'package:todo_app/services/networking.dart';

const tasksListURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

class TaskData extends ChangeNotifier {
  Map<DateTime, List<Task>> groupedTasks = {};
  int _status = 0;

  List<TaskStatus> taskStatus =
      List<TaskStatus>.generate(3, (_) => TaskStatus(tasks: []));

  Future<dynamic> _getTasksList(
      {required int offset, required int limit}) async {
    String status = '';

    if (_status == 0) {
      status = 'TODO';
    } else if (_status == 1) {
      status = 'DOING';
    } else if (_status == 2) {
      status = 'DONE';
    }

    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.parse(
          '$tasksListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=$status'),
    );

    // print('$tasksListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=$status');

    dynamic tasksList = await networkHelper.getData();

    return tasksList;
  }

  void _genGroupedTasks() {
    groupedTasks.clear();
    for (final Task task in taskStatus[_status].tasks) {
      DateTime dateTime = DateTime(
          task.createdAt.year, task.createdAt.month, task.createdAt.day);
      if (!groupedTasks.containsKey(dateTime)) {
        groupedTasks[dateTime] = [];
      }
      groupedTasks[dateTime]?.add(task);
    }
  }

  int _getNextPage() {
    if (taskStatus[_status].currentPage < taskStatus[_status].totalPages) {
      final nextPage = taskStatus[_status].currentPage + 1;
      return nextPage;
    } else {
      return -1;
    }
  }

  void loadTasks({required int offset, required int limit}) async {
    taskStatus[_status].loading = true;
    taskStatus[_status].currentPage = offset;

    dynamic data = await _getTasksList(offset: offset, limit: limit);

    for (var d in data['tasks'] ?? []) {
      final Task task = Task(
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

    _genGroupedTasks();

    Future.delayed(const Duration(milliseconds: 20), () {
      taskStatus[_status].loading = false; // Reset the flag after
    });

    notifyListeners();
  }

  Future<void> loadMoreItems() async {
    if (taskStatus[_status].loading == false) {
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

  int getStatus() {
    return _status;
  }

  void removeTask(String id) {
    taskStatus[_status].tasks.removeWhere((task) => task.id == id);
    _genGroupedTasks();
    notifyListeners();
  }
}
