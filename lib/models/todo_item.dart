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
  String? project; //TODO change to model
  String? label; //TODO change to model
  String? status; //TODO change to model
  TodoPriority? priority;

  TodoItem({
    String? id,
    required this.title,
    required this.status,
    this.isDone = false,
    this.label,
    this.project,
    this.priority,
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
