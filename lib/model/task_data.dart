import 'package:todo_app/model/task.dart';

class TaskData {
  List<Task> tasks = [];
  int _currentPage = 0;
  int _totalPages = 0;
  bool isLoading = false;

  TaskData();

  void add(List<dynamic> data) {
    for (var d in data) {
      final Task task = Task(
        id: d['id'] ?? '',
        title: d['title'] ?? '',
        description: d['description'] ?? '',
        createdAt: DateTime.tryParse(d['createdAt'] ?? '') ?? DateTime.now(),
        status: d['status'] ?? '',
      );

      if (!tasks.any((obj) => obj.id == task.id)) {
        tasks.add(task);
      }
    }
  }

  Map<DateTime, List<Task>> getGroupedTasks() {
    final Map<DateTime, List<Task>> groupedTasks = {};

    for (final Task task in tasks) {
      DateTime dateTime = DateTime(
          task.createdAt.year, task.createdAt.month, task.createdAt.day);

      if (!groupedTasks.containsKey(dateTime)) {
        groupedTasks[dateTime] = [];
      }

      groupedTasks[dateTime]?.add(task);
    }

    return groupedTasks;
  }

  void setTotalPages(int pages) {
    _totalPages = pages;
  }

  void setCurrentPage(int page) {
    _currentPage = page;
  }

  int getNextPage() {
    if (_currentPage < _totalPages) {
      final nextPage = _currentPage + 1;
      return nextPage;
    } else {
      return -1;
    }
  }
}
