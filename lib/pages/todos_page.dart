import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/blocs/todo_bloc.dart';

import '../widgets/todo/todo_items_list.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => TodoBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.grid_outline,
                color: Colors.white,
                size: 26,
              ),
            ),
            title: const SizedBox(
              width: 230,
              child: SearchBar(
                elevation: MaterialStatePropertyAll(0),
                leading: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                constraints: BoxConstraints(minHeight: 36, maxHeight: 36),
              ),
            ),
            actions: [
              CircleAvatar(
                radius: 26,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.4),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.ellipsis_horizontal_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
            backgroundColor: Theme.of(context).highlightColor.withOpacity(0.70),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(72),
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 14),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today, ${DateFormat('d MMMM').format(DateTime.now())}",
                      ),
                      Text(
                        "My tasks",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: const TodoItemList(),
          bottomSheet: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Ionicons.list,
                        size: 34,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Ionicons.calendar_clear_outline,
                        size: 34,
                      ),
                      label: ""),
                ],
              ),
              Positioned(
                top: -20,
                child: IconButton.filled(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(5),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).highlightColor),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      constraints:
                          BoxConstraints.tight(const Size.fromHeight(100)),
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return StatefulBuilder(
                          builder: (buildCtx, setState) {
                            return AnimatedPadding(
                              padding: MediaQuery.of(context).viewInsets,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.decelerate,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  const Text(
                                    'What would you like to do?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(child: TextField()),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
