import 'package:todo_list/providers/todo/todo_provider.dart';

import '../../models/todo/todo_item.dart';
import '../../models/todo/todo_priority.dart';

class TodoMockProvider extends TodoProvider {
  @override
  Future<TodoItem> create(TodoItem itemToCreate) async {
    //* Assume todo item creation
    await Future.delayed(const Duration(milliseconds: 500));
    _todoItems.add(itemToCreate);
    return itemToCreate;
  }

  @override
  Future<bool> delete(String id) async {
    //* Assume todo item deletion
    await Future.delayed(const Duration(milliseconds: 500));
    _todoItems.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<TodoItem>> getAll() async {
    //* Assume todo items are fetching
    await Future.delayed(const Duration(milliseconds: 500));
    return _todoItems;
  }

  @override
  Future<TodoItem> getById(String id) async {
    //* Assume todo item is fetching
    await Future.delayed(const Duration(milliseconds: 500));
    return _todoItems.firstWhere((element) => element.id == id);
  }

  @override
  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData) async {
    //* Assume todo item is updating
    await Future.delayed(const Duration(milliseconds: 500));
    _todoItems[_todoItems
        .indexWhere((element) => element.id == idOfItemToUpdate)] = newItemData;
    return _todoItems.firstWhere((element) => element.id == idOfItemToUpdate);
  }

  final List<TodoItem> _todoItems = [
    TodoItem(
      title: 'Complete Flutter project',
      dueDate: DateTime.now(),
      priority: TodoPriority.high,
      authorId: '',
    ),
    TodoItem(
      title: 'Read a book',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: TodoPriority.low,
      authorId: '',
    ),
    TodoItem(
      title: 'Write blog post',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: TodoPriority.high,
      authorId: '',
    ),
    TodoItem(
      title: 'Exercise',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: TodoPriority.medium,
      authorId: '',
    ),
    TodoItem(
      title: 'Learn a new programming language',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: TodoPriority.low,
      authorId: '',
    ),
    TodoItem(
      title: 'Attend team meeting',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      priority: TodoPriority.low,
      authorId: '',
    ),
    TodoItem(
      title: 'Prepare for exam',
      dueDate: DateTime.now().add(const Duration(days: 6)),
      priority: TodoPriority.low,
      authorId: '',
    ),
    TodoItem(
      title: 'Cook a new recipe',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      authorId: '',
    ),
    TodoItem(
      title: 'Plan weekend getaway',
      dueDate: DateTime.now().add(const Duration(days: 8)),
      authorId: '',
    ),
    TodoItem(
      title: 'Complete GPT-3 tutorial',
      dueDate: DateTime.now(),
      priority: TodoPriority.high,
      authorId: '',
    ),
  ];

  @override
  Future<List<TodoItem>> getAllByTitle(String title) {
    // TODO: implement getAllByTitle
    throw UnimplementedError();
  }
}
