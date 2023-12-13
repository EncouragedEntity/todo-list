import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/states/todo_state.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/widgets/todo/todo_list_tile.dart';

import '../../models/todo_item.dart';
import '../../models/todo_priority.dart';

class TodoItemList extends StatefulWidget {
  const TodoItemList({Key? key, this.groupByPriority = false})
      : super(key: key);

  final bool groupByPriority;

  @override
  State<TodoItemList> createState() => _TodoItemListState();
}

class _TodoItemListState extends State<TodoItemList> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<TodoBloc>().state is! TodoItemsLoadedState) {
      context.read<TodoBloc>().add(TodoLoadAllItemsEvent());
    }
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (todoCtx, todoState) {
        if (todoState is TodoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (todoState is TodoItemsLoadedState) {
          Logger().i(todoState.items);
          final groupedItems = widget.groupByPriority
              ? _groupItemsByPriority(todoState.items)
              : _groupItemsByDate(todoState.items);

          return Padding(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<TodoBloc>().add(TodoLoadAllItemsEvent());
              },
              child: GroupedListView<dynamic, dynamic>(
                elements: groupedItems,
                groupBy: (element) => element['group'],
                groupComparator: (group1, group2) {
                  final priorityOrder = [
                    'High Priority',
                    'Medium Priority',
                    'Low Priority'
                  ];
                  final index1 = priorityOrder.indexOf(group1);
                  final index2 = priorityOrder.indexOf(group2);
                  return index1.compareTo(index2);
                },
                itemComparator: (item1, item2) {
                  if (widget.groupByPriority) {
                    return item1['priority'].compareTo(item2['priority']);
                  } else {
                    final dueDate1 = item1['dueDate'] as DateTime?;
                    final dueDate2 = item2['dueDate'] as DateTime?;

                    if (dueDate1 != null && dueDate2 != null) {
                      return dueDate1.compareTo(dueDate2);
                    } else if (dueDate1 == null && dueDate2 == null) {
                      return 0;
                    } else {
                      return dueDate1 != null ? 1 : -1;
                    }
                  }
                },
                groupSeparatorBuilder: (dynamic value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.toString(),
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
                  }
                  return Center(
                    child: Text(
                      'Empty here :)',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Map<String, dynamic>> _groupItemsByDate(List<TodoItem> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayPlusDay = today.add(const Duration(days: 1));
    final tomorrow = now.copyWith(day: now.day + 1);

    final List<Map<String, dynamic>> groupedItems = [];

    groupedItems.add({
      'group': 'Today',
      'items': items
          .where((item) =>
              item.dueDate.isAtSameMomentAs(today) ||
              item.dueDate.isAfter(today) &&
                  item.dueDate.isBefore(todayPlusDay))
          .toList(),
    });

    final tomorrowItems =
        items.where((item) => item.dueDate.day == tomorrow.day).toList();

    groupedItems.add({
      'group': 'Tomorrow',
      'items': tomorrowItems,
    });

    final thisWeekItems = items.where((item) {
      return item.dueDate.isAfter(tomorrow);
    }).toList();

    groupedItems.add({
      'group': 'This Week',
      'items': thisWeekItems,
    });

    return groupedItems;
  }

  List<Map<String, dynamic>> _groupItemsByPriority(List<TodoItem> items) {
    final List<Map<String, dynamic>> groupedItems = [];

    groupedItems.add({
      'group': 'Low Priority',
      'items':
          items.where((item) => item.priority == TodoPriority.low).toList(),
    });

    groupedItems.add({
      'group': 'Medium Priority',
      'items':
          items.where((item) => item.priority == TodoPriority.medium).toList(),
    });

    groupedItems.add({
      'group': 'High Priority',
      'items':
          items.where((item) => item.priority == TodoPriority.high).toList(),
    });

    return groupedItems;
  }
}
