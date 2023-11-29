import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/models/todo_priority.dart';
import 'package:uuid/uuid.dart';

@JsonSerializable()
class TodoItem {
  String? id;
  String title;
  bool isDone;
  DateTime dueDate;
  TodoPriority priority;

  TodoItem({
    String? id,
    required this.title,
    this.isDone = false,
    this.priority = TodoPriority.medium,
    required this.dueDate,
  }) {
    if (id == null) {
      this.id = const Uuid().v4();
    }
  }

  String get formattedDateDayMonth {
    return DateFormat('d MMMM').format(dueDate);
  }
}
