import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/states/todo_state.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/widgets/todo/todo_list_tile.dart';

import '../../models/todo_item.dart';

class TodoItemList extends StatefulWidget {
  const TodoItemList({super.key});

  @override
  State<TodoItemList> createState() => _TodoItemListState();
}

class _TodoItemListState extends State<TodoItemList> {
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(TodoLoadAllItemsEvent());
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (todoCtx, todoState) {
        if (todoState is TodoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (todoState is TodoItemsLoadedState) {
          Logger().i(todoState.items);
          final groupedItems = _groupItemsByDate(todoState.items);

          return Padding(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<TodoBloc>().add(TodoLoadAllItemsEvent());
              },
              child: GroupedListView<dynamic, String>(
                elements: groupedItems,
                groupBy: (element) => element['group'],
                groupComparator: (value1, value2) {
                  if (value1 == 'Today') {
                    return -1;
                  } else if (value2 == 'Today') {
                    return 1;
                  }
                  return value2.compareTo(value1);
                },
                itemComparator: (item1, item2) =>
                    item1['dueDate'].compareTo(item2['dueDate']),
                order: GroupedListOrder.ASC,
                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16),
                  ),
                ),
                itemBuilder: (context, element) {
                  final items = element['items'] as List<TodoItem>?;

                  if (items != null && items.isNotEmpty) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...items.map((e) => TodoItemListTile(item: e)),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        }
        return const Center(
          child: Text("Something's wrong"),
        );
      },
    );
  }

  List<Map<String, dynamic>> _groupItemsByDate(List<TodoItem> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final thisWeek = today.add(const Duration(days: 7));

    final List<Map<String, dynamic>> groupedItems = [];

    groupedItems.add({
      'group': 'Today',
      'items': items
          .where((item) =>
              item.dueDate.isBefore(tomorrow) && item.dueDate.isAfter(today))
          .toList(),
    });

    groupedItems.add({
      'group': 'Tomorrow',
      'items': items.where((item) => item.dueDate.day == tomorrow.day).toList(),
    });

    groupedItems.add({
      'group': 'This Week',
      'items': items
          .where((item) =>
              item.dueDate.isAfter(tomorrow) && item.dueDate.isBefore(thisWeek))
          .toList(),
    });

    return groupedItems;
  }
}
