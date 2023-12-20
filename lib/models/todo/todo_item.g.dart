// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
      priority: $enumDecodeNullable(_$TodoPriorityEnumMap, json['priority']) ??
          TodoPriority.medium,
      dueDate: DateTime.parse(json['dueDate'] as String),
      authorId: json['authorId'] as String? ?? '',
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'title': instance.title,
      'isDone': instance.isDone,
      'dueDate': instance.dueDate.toIso8601String(),
      'priority': _$TodoPriorityEnumMap[instance.priority]!,
    };

const _$TodoPriorityEnumMap = {
  TodoPriority.high: 'high',
  TodoPriority.medium: 'medium',
  TodoPriority.low: 'low',
};
