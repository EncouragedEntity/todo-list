import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/states/todo_state.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/widgets/todo/todo_list_tile.dart';

import '../../models/todo_item.dart';
import '../../models/todo_priority.dart';

class TodoItemList extends StatefulWidget {
  const TodoItemList({Key? key}) : super(key: key);

  @override
  State<TodoItemList> createState() => _TodoItemListState();
}

class _TodoItemListState extends State<TodoItemList> {
  bool groupByPriority = false;
  final sortingButtonKey = GlobalKey();

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
          final groupedItems = groupByPriority
              ? _groupItemsByPriority(todoState.items)
              : _groupItemsByDate(todoState.items);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  if (groupByPriority) {
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
                groupSeparatorBuilder: (dynamic value) {
                  if (value.toString() == 'Today' ||
                      value.toString() == 'High Priority') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 16),
                          ),
                          ElevatedButton.icon(
                            key: sortingButtonKey,
                            onPressed: () async {
                              RenderBox renderbox = sortingButtonKey
                                  .currentContext!
                                  .findRenderObject() as RenderBox;
                              final RenderBox overlay = Overlay.of(context)
                                  .context
                                  .findRenderObject() as RenderBox;
                              final RelativeRect position =
                                  RelativeRect.fromRect(
                                Rect.fromPoints(
                                  renderbox.localToGlobal(Offset.zero,
                                      ancestor: overlay),
                                  renderbox.localToGlobal(
                                      renderbox.size.bottomRight(Offset.zero),
                                      ancestor: overlay),
                                ),
                                Offset.zero & overlay.size,
                              );

                              final result = await showMenu<bool>(
                                context: context,
                                position: position,
                                items: [
                                  PopupMenuItem(
                                    onTap: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Ionicons.calendar_number_outline,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                      title: const Text('Due Date'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Ionicons.warning_outline,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                      title: const Text('Priority'),
                                    ),
                                  )
                                ],
                              );
                              if (groupByPriority != result) {
                                setState(() {
                                  groupByPriority = result ?? false;
                                });

                                // ignore: use_build_context_synchronously
                                context
                                    .read<TodoBloc>()
                                    .add(TodoLoadAllItemsEvent());
                              }
                            },
                            icon: const Icon(Ionicons.swap_vertical_outline),
                            label: Text(value.toString() == 'Today'
                                ? 'Date'
                                : 'Priority'),
                          )
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16),
                    ),
                  );
                },
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
