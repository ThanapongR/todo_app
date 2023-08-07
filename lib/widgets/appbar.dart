import 'package:flutter/material.dart';
import 'package:todo_app/utilities/constants.dart';
import 'package:todo_app/widgets/task_badge.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 172.0,
      collapsedHeight: 72.0,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        title: const SafeArea(child: TaskBadge()),
        background: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 32.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: const CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                ),
                const Text(
                  "Hi! Bob",
                  style: TextStyle(fontSize: 28.0),
                ),
                const Text("Welcome to To-Do app"),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
    );
  }
}
