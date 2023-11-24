import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo_item.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {}

class TodoItemsLoadedState extends TodoState {
  final List<TodoItem> items;

  TodoItemsLoadedState(this.items);
  @override
  List<Object> get props => [items];
}
