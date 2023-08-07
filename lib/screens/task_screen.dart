import 'package:flutter/material.dart' hide AppBar;
import 'package:provider/provider.dart';
import 'package:todo_app/model/lock_model.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/widgets/appbar.dart';
import 'package:todo_app/widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100.0) {
        context.read<TaskModel>().loadMoreItems();
      }
    });

    context.read<LockModel>().loadLastActiveTime(context);

    return Scaffold(
      body: Listener(
        child: CustomScrollView(
          controller: scrollController,
          slivers: const <Widget>[
            AppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            TaskList(),
            SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          ],
        ),
        onPointerDown: (_) {
          context.read<LockModel>().updateActivity(context);
        },
        onPointerMove: (_) {
          context.read<LockModel>().updateActivity(context);
        },
      ),
    );
  }
}
