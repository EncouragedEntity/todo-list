import '../../models/todo_item.dart';

abstract class TodoProvider {
  Future<List<TodoItem>> getAll();
  Future<TodoItem> getById(String id);
  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData);
  Future<bool> delete(String id);
  Future<TodoItem> create(TodoItem itemToCreate);
}
