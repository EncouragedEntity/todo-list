import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'todo_priority.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  String? id;
  String authorId;
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
    this.authorId = '',
  }) {
    if (id == null) {
      this.id = const Uuid().v4();
    }
  }

  String get formattedDateDayMonth {
    return DateFormat('d MMMM').format(dueDate);
  }

  String get formattedDate {
    return DateFormat('dd.MM.yyyy').format(dueDate);
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
