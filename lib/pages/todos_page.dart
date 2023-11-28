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

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  bool _groupByPriority = false;

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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return Material(
                            color: Colors.transparent,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Container(
                                  width: 300,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 4,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 36,
                                            ),
                                            Text(
                                              "Sort by",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(Icons.close,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Ionicons.calendar_number_outline,
                                            color: Theme.of(context)
                                                .highlightColor,
                                          ),
                                          title: const Text('Due Date'),
                                          trailing: Radio(
                                            fillColor: MaterialStatePropertyAll(
                                                Theme.of(context)
                                                    .highlightColor),
                                            value: false,
                                            groupValue: _groupByPriority,
                                            onChanged: (value) {
                                              setState(() {
                                                _groupByPriority =
                                                    value as bool;
                                              });
                                              Navigator.pop(ctx);
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Ionicons.warning_outline,
                                            color: Theme.of(context)
                                                .highlightColor,
                                          ),
                                          title: const Text('Priority'),
                                          trailing: Radio(
                                            fillColor: MaterialStatePropertyAll(
                                                Theme.of(context)
                                                    .highlightColor),
                                            value: true,
                                            groupValue: _groupByPriority,
                                            onChanged: (value) {
                                              setState(() {
                                                _groupByPriority =
                                                    value as bool;
                                              });
                                              Navigator.pop(ctx);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
