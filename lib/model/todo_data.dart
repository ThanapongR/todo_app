import 'package:todo_app/model/todo.dart';

class ToDoData {
  List<ToDo> list = [];

  ToDoData();

  add(List<dynamic> data) {
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
}
