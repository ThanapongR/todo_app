import 'package:todo_app/model/task.dart';

class TaskStatus {
  List<Task> tasks;
  int currentPage;
  int totalPages;
  bool initiated;
  bool loading;

  TaskStatus({
    required this.tasks,
    this.currentPage = -1,
    this.totalPages = 0,
    this.initiated = false,
    this.loading = false,
  });
}
