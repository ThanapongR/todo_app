import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_data.dart';
import 'package:todo_app/services/todo_list.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final ScrollController _scrollController = ScrollController();
  final ToDoData _todo = ToDoData();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    int nextPage = _todo.getNextPage();
    if (nextPage >= 0) {
      final dynamic data =
          await ToDoList().getTodoList(offset: nextPage, limit: 10);
      setState(() {
        _todo.add(data['tasks']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ToDoList().getTodoList(offset: 0, limit: 10),
        builder: (context, snapshot) {
          Widget newsListSliver;
          if (snapshot.hasData) {
            _todo.setTotalPages(snapshot.data['totalPages']);
            _todo.add(snapshot.data['tasks']);
            newsListSliver = SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                    top: 16.0,
                    right: 32.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _todo.list[index].createdAt,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.local_activity),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _todo.list[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _todo.list[index].description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.more_vert,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              childCount: _todo.list.length,
            ));
          } else {
            newsListSliver = SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
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
                  height: 20.0,
                ),
              ),
              newsListSliver,
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
