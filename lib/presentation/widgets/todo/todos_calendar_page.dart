import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/logic/blocs/states/todo_state.dart';
import 'package:todo_list/logic/blocs/todo_bloc.dart';
import 'package:todo_list/presentation/widgets/todo/todo_list_tile.dart';

import 'styled_calendar.dart';

class TodosCalendarPage extends StatefulWidget {
  const TodosCalendarPage({super.key});

  @override
  State<TodosCalendarPage> createState() => _TodosCalendarPageState();
}

class _TodosCalendarPageState extends State<TodosCalendarPage> {
  CalendarFormat _selectedFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedFormat = CalendarFormat.month;
                          });
                        },
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          color: _selectedFormat == CalendarFormat.month
                              ? Theme.of(context).highlightColor
                              : Colors.grey.shade400,
                          size: 48,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedFormat = CalendarFormat.week;
                          });
                        },
                        icon: Icon(
                          Icons.calendar_view_day_rounded,
                          color: _selectedFormat == CalendarFormat.week
                              ? Theme.of(context).highlightColor
                              : Colors.grey.shade400,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state is TodoItemsLoadedState) {
                        final items = state.items;
                        return StyledCalendar(
                          selectedFormat: _selectedFormat,
                          items: items,
                          onDaySelected: (selectedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          },
                          onFormatChanged: (format) {
                            setState(() {
                              _selectedFormat = format;
                            });
                          },
                        );
                      }
                      return StyledCalendar(
                        selectedFormat: _selectedFormat,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoItemsLoadedState) {
              final items = state.items;
              final currentDayItems = items
                  .where(
                    (element) => isSameDay(
                      element.dueDate,
                      _selectedDay,
                    ),
                  )
                  .toList();
              return SliverPadding(
                padding: const EdgeInsets.only(top: 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TodoItemListTile(
                        item: currentDayItems[index],
                      );
                    },
                    childCount: currentDayItems.length,
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildListDelegate([
                Container(),
              ]),
            );
          },
        ),
      ],
    );
  }
}
