import 'package:todo_app/model/todo.dart';

class ToDoData {
  List<ToDo> list = [];
  int _currentPage = 0;
  int _totalPages = 0;
  bool isLoading = false;

  ToDoData();

  void add(List<dynamic> data) {
    for (var d in data) {
      final ToDo todo = ToDo(
        id: d['id'] ?? '',
        title: d['title'] ?? '',
        description: d['description'] ?? '',
        createdAt: DateTime.tryParse(d['createdAt'] ?? '') ?? DateTime.now(),
        status: d['status'] ?? '',
      );

      if (!list.any((obj) => obj.id == todo.id)) {
        list.add(todo);
      }
    }
  }

  Map<DateTime, List<ToDo>> getGroupedTasks() {
    final Map<DateTime, List<ToDo>> groupedTasks = {};

    for (final ToDo l in list) {
      DateTime dateTime =
          DateTime(l.createdAt.year, l.createdAt.month, l.createdAt.day);

      if (!groupedTasks.containsKey(dateTime)) {
        groupedTasks[dateTime] = [];
      }

      groupedTasks[dateTime]?.add(l);
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
