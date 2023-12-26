import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../logic/models/todo/todo_item.dart';

class StyledCalendar extends StatefulWidget {
  const StyledCalendar({
    super.key,
    required this.selectedFormat,
    this.selectedDay,
    this.items,
    this.onDaySelected,
    this.onFormatChanged,
  });
  final CalendarFormat selectedFormat;
  final DateTime? selectedDay;
  final List<TodoItem>? items;
  final void Function(dynamic selectedDay)? onDaySelected;
  final void Function(CalendarFormat)? onFormatChanged;

  @override
  State<StyledCalendar> createState() => _StyledCalendarState();
}

class _StyledCalendarState extends State<StyledCalendar> {
  late CalendarFormat _selectedFormat;
  late DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    _selectedFormat = widget.selectedFormat;
    super.initState();
  }

  @override
  void didUpdateWidget(StyledCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedFormat != widget.selectedFormat) {
      setState(() {
        _selectedFormat = widget.selectedFormat;
      });
    }

    if (oldWidget.selectedDay != null &&
        oldWidget.selectedDay != _selectedDay) {
      setState(() {
        _selectedDay = widget.selectedDay!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime.now().copyWith(year: DateTime.now().year - 1),
      lastDay: DateTime.now().copyWith(year: DateTime.now().year + 1),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      eventLoader: widget.items != null
          ? (day) {
              return widget.items!
                  .where((element) => isSameDay(element.dueDate, day))
                  .toList();
            }
          : null,
      calendarFormat: _selectedFormat,
      onFormatChanged: (format) {
        setState(() {
          _selectedFormat = format;
        });

        if (widget.onFormatChanged != null) {
          widget.onFormatChanged!(format);
        }
      },
      currentDay: _selectedDay,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
        if (widget.onDaySelected != null) {
          widget.onDaySelected!(selectedDay);
        }
      },
      daysOfWeekHeight: 18,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronMargin: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
        headerPadding: EdgeInsets.only(right: 120),
        leftChevronIcon: Icon(
          Ionicons.chevron_back_outline,
          color: Colors.grey,
        ),
        rightChevronIcon: Icon(
          Ionicons.chevron_forward_outline,
          color: Colors.grey,
        ),
      ),
      calendarStyle: CalendarStyle(
        canMarkersOverflow: false,
        markersMaxCount: 1,
        markerDecoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(90),
        ),
        markerMargin: const EdgeInsets.only(top: 6),
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(90),
        ),
        markerSizeScale: 0.15,
        cellMargin: const EdgeInsets.all(8),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Padding(
            padding: const EdgeInsets.only(top: 0, left: 24),
            child: Text(
              DateFormat.E().format(day).toString()[0].toUpperCase(),
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return Container();
        },
        defaultBuilder: (context, day, focusedDay) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.grey),
            ),
          );
        },
        headerTitleBuilder: (context, day) {
          if (_selectedFormat == CalendarFormat.month) {
            return Text(
              DateFormat.yMMMM().format(day),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            );
          }
          return Text(
            "${isSameDay(day, DateTime.now()) ? "Today, " : ""}${DateFormat.MMMd().format(day)}",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          );
        },
      ),
    );
  }
}
