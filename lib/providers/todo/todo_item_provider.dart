import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/providers/todo/todo_provider.dart';

//TODO implement TodoItemProvider
class TodoItemProvider extends TodoProvider {
  @override
  Future<TodoItem> create(TodoItem itemToCreate) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TodoItem>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<TodoItem> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData) {
    throw UnimplementedError();
  }
}
