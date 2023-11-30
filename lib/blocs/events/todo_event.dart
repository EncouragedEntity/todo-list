import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo_item.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoadAllItemsEvent extends TodoEvent {}

class TodoAddNewItemEvent extends TodoEvent {
  final TodoItem item;

  TodoAddNewItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class TodoUpdateItemEvent extends TodoEvent {
  final TodoItem item;

  TodoUpdateItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class TodoRemoveItemEvent extends TodoEvent {
  final TodoItem item;

  TodoRemoveItemEvent(this.item);

  @override
  List<Object> get props => [item];
}
