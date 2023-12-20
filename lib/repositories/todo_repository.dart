import 'package:todo_list/providers/todo/todo_provider.dart';

import '../models/todo/todo_item.dart';

class TodoRepository {
  final TodoProvider todoProvider;

  TodoRepository(this.todoProvider);

  Future<TodoItem> create(TodoItem itemToCreate) async {
    return await todoProvider.create(itemToCreate);
  }

  Future<bool> delete(String id) async {
    return await todoProvider.delete(id);
  }

  Future<List<TodoItem>> getAll() async {
    return await todoProvider.getAll();
  }

  Future<List<TodoItem>> getAllByTitle(String title) async {
    return await todoProvider.getAllByTitle(title);
  }

  Future<TodoItem?> getById(String id) async {
    return await todoProvider.getById(id);
  }

  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData) async {
    return await todoProvider.update(idOfItemToUpdate, newItemData);
  }
}
