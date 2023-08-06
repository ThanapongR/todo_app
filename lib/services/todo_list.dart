import 'package:todo_app/services/networking.dart';

const toDoListURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

class ToDoList {
  Future<dynamic> getTodoList() async {
    NetworkHelper networkHelper = NetworkHelper(
        url: Uri.parse(
            '$toDoListURL?offset=0&limit=10&sortBy=createdAt&isAsc=true&status=TODO'));

    dynamic todoList = await networkHelper.getData();

    return todoList;
  }
}
