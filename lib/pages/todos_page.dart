import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/models/todo_item.dart';

import '../blocs/states/todo_state.dart';
import '../widgets/todo/new_item_modal_sheet.dart';
import '../widgets/todo/todo_items_list.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (ctx) => TodoBloc(),
      child: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return Scaffold(
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
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor.withOpacity(0.4),
                      ),
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromRadius(26)),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.ellipsis_horizontal_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
                backgroundColor:
                    Theme.of(context).highlightColor.withOpacity(0.70),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).highlightColor)),
                onPressed: () async {
                  TodoItem? item = await showModalBottomSheet<TodoItem>(
                    useSafeArea: true,
                    context: context,
                    builder: (ctx) {
                      return const NewTodoItemModalSheet();
                    },
                  );

                  if (item != null) {
                    context.read<TodoBloc>().add(TodoAddNewItemEvent(item));
                  }
                },
                icon: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: const TodoItemList(),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Ionicons.list, size: 34),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Ionicons.calendar_clear_outline, size: 34),
                    label: "",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}