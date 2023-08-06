import 'package:todo_app/model/task.dart';

class TaskStatus {
  List<Task> tasks;
  int currentPage;
  int totalPages;
  bool loading;

  TaskStatus({
    required this.tasks,
    this.currentPage = 0,
    this.totalPages = 0,
    this.loading = false,
  });
}
