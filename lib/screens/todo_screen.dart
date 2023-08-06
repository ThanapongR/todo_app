import 'package:flutter/material.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
              title: const SafeArea(
                child: ToDoBadge(),
              ),
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
            backgroundColor: const Color(0xFFECEDFD),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoBadge extends StatelessWidget {
  const ToDoBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
        right: 12.0,
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            selected: true,
            title: 'To-do',
          ),
          SizedBox(
            width: 8.0,
          ),
          Badge(
            selected: false,
            title: 'Doing',
          ),
          SizedBox(
            width: 8.0,
          ),
          Badge(
            selected: false,
            title: 'Done',
          ),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final bool selected;
  final String title;

  const Badge({
    super.key,
    required this.selected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 4.0,
        right: 12.0,
        bottom: 4.0,
      ),
      decoration: selected
          ? BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF86CAF6),
                  Color(0xFFA1A5E8),
                ],
              ),
              borderRadius: BorderRadius.circular(32.0),
            )
          : BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(32.0),
            ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: selected ? Colors.white : Colors.black26,
        ),
      ),
    );
  }
}
