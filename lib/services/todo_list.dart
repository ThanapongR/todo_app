import 'package:todo_app/services/networking.dart';

const toDoListURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

class ToDoList {
  Future<dynamic> getTodoList({required int offset, required int limit}) async {
    print(
        '$toDoListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=TODO');

    NetworkHelper networkHelper = NetworkHelper(
        url: Uri.parse(
            '$toDoListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=TODO'));

    dynamic todoList = await networkHelper.getData();

    return todoList;
  }
}
