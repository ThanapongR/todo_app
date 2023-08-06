import 'package:todo_app/services/networking.dart';

const tasksListURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

class TaskList {
  Future<dynamic> getTasksList(
      {required int offset, required int limit}) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: Uri.parse(
            '$tasksListURL?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=TODO'));

    dynamic tasksList = await networkHelper.getData();

    return tasksList;
  }
}
