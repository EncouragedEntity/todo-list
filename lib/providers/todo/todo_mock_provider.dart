import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/providers/todo/todo_provider.dart';

import '../../models/todo_priority.dart';

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
      status: 'In Progress',
      dueDate: DateTime.now(),
      priority: TodoPriority.high,
    ),
    TodoItem(
      title: 'Read a book',
      status: 'To Do',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      label: 'Personal',
    ),
    TodoItem(
      title: 'Write blog post',
      status: 'To Do',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      project: 'Blogging',
    ),
    TodoItem(
      title: 'Exercise',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: TodoPriority.medium,
      label: 'Health',
    ),
    TodoItem(
      title: 'Learn a new programming language',
      status: 'To Do',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    TodoItem(
      title: 'Attend team meeting',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      project: 'Work',
    ),
    TodoItem(
      title: 'Prepare for exam',
      status: 'To Do',
      dueDate: DateTime.now().add(const Duration(days: 6)),
      priority: TodoPriority.low,
    ),
    TodoItem(
      title: 'Cook a new recipe',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      label: 'Cooking',
    ),
    TodoItem(
      title: 'Plan weekend getaway',
      status: 'To Do',
      dueDate: DateTime.now().add(const Duration(days: 8)),
    ),
    TodoItem(
      title: 'Complete GPT-3 tutorial',
      status: 'In Progress',
      dueDate: DateTime.now(),
      priority: TodoPriority.high,
      project: 'Learning',
    ),
  ];
}
