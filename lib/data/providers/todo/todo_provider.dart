import 'package:todo_list/logic/models/todo/todo_item.dart';

abstract class TodoProvider {
  Future<List<TodoItem>> getAll();
  Future<List<TodoItem>> getAllByTitle(String title);
  Future<TodoItem?> getById(String id);
  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData);
  Future<bool> delete(String id);
  Future<TodoItem> create(TodoItem itemToCreate);
}
