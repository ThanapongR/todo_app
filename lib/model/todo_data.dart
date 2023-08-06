import 'package:todo_app/model/todo.dart';

class ToDoData {
  List<ToDo> list = [];
  int _currentPage = 0;
  int _totalPages = 0;

  ToDoData();

  void add(List<dynamic> data) {
    for (var d in data) {
      final ToDo todo = ToDo(
        id: d['id'] ?? '',
        title: d['title'] ?? '',
        description: d['description'] ?? '',
        createdAt: d['createdAt'] ?? '',
        status: d['status'] ?? '',
      );

      if (!list.any((obj) => obj.id == todo.id)) {
        list.add(todo);
      }
    }
  }

  void setTotalPages(int pages) {
    _totalPages = pages;
  }

  int getNextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      return _currentPage;
    } else {
      return -1;
    }
  }
}
