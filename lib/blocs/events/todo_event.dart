import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo/todo_item.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoadAllItemsEvent extends TodoEvent {}

class TodoLoadAllItemsByTitleEvent extends TodoEvent {
  final String itemTitle;
  TodoLoadAllItemsByTitleEvent({this.itemTitle = ""});

  @override
  List<Object> get props => [itemTitle];
}

class TodoAddNewItemEvent extends TodoEvent {
  final TodoItem item;

  TodoAddNewItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class TodoUpdateItemEvent extends TodoEvent {
  final String idOfItemToUpdate;
  final TodoItem item;

  TodoUpdateItemEvent(this.idOfItemToUpdate, this.item);

  @override
  List<Object> get props => [idOfItemToUpdate, item];
}

class TodoRemoveItemEvent extends TodoEvent {
  final TodoItem item;

  TodoRemoveItemEvent(this.item);

  @override
  List<Object> get props => [item];
}
