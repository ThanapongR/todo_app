import 'package:flutter/material.dart' hide AppBar;
import 'package:provider/provider.dart';
import 'package:todo_app/model/lock_provider.dart';
import 'package:todo_app/model/scroll_controller_provider.dart';
import 'package:todo_app/model/task_provider.dart';
import 'package:todo_app/widgets/appbar.dart';
import 'package:todo_app/widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LockProvider>().loadLastActiveTime(context);

    ScrollControllerProvider scrollControllerProvider =
        context.read<ScrollControllerProvider>();
    ScrollController scrollController =
        scrollControllerProvider.scrollController;

    scrollControllerProvider.addScrollListener(() {
      if (context.mounted) {
        scrollControllerProvider.saveScrollOffset();
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100.0) {
          context.read<TaskProvider>().loadMoreItems();
        }
      }
    });

    // Restore the scroll offset when returning to this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScrollControllerProvider>().restoreScrollOffset();
    });

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
          context.read<LockProvider>().updateActivity(context);
        },
        onPointerMove: (_) {
          context.read<LockProvider>().updateActivity(context);
        },
      ),
    );
  }
}
