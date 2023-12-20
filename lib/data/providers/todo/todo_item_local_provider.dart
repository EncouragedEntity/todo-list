import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:localstore/localstore.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/data/providers/todo/todo_provider.dart';
import 'package:todo_list/logic/models/auth/user.dart';
import 'package:todo_list/logic/models/todo/todo_item.dart';

class TodoItemLocalProvider extends TodoProvider {
  CollectionRef? collection;
  late final User currentUser;

  TodoItemLocalProvider() {
    initialize();
  }

  Future<void> initialize() async {
    currentUser = User.fromJson(await SessionManager().get('currentUser'));
    if (currentUser.id != null) {
      collection = Localstore.instance.collection(currentUser.id!);
      return;
    }
    throw Exception('Current user is invalid');
  }

  @override
  Future<TodoItem> create(TodoItem itemToCreate) async {
    itemToCreate.authorId = currentUser.id!;
    await collection!.doc(itemToCreate.id).set(itemToCreate.toJson());
    Logger().d(collection!.path);
    return itemToCreate;
  }

  @override
  Future<bool> delete(String id) async {
    await collection!.doc(id).delete();
    return true;
  }

  @override
  Future<List<TodoItem>> getAll() async {
    final List<TodoItem> todoItems = [];
    final Map<String, dynamic>? snapshot =
        await collection!.where('authorId', isEqualTo: currentUser.id).get();
    if (snapshot == null) {
      return List<TodoItem>.empty();
    }

    for (final doc in snapshot.values) {
      final item = TodoItem.fromJson(doc);
      item.id = doc['id'];
      todoItems.add(item);
    }

    return todoItems;
  }

  @override
  Future<List<TodoItem>> getAllByTitle(String title) async {
    if (title.isEmpty) {
      return getAll();
    }

    List<TodoItem> filteredTodoItems = [];

    final Map<String, dynamic>? snapshot =
        await collection!.where('authorId', isEqualTo: currentUser.id).get();

    if (snapshot == null) {
      return List<TodoItem>.empty();
    }

    for (final doc in snapshot.values) {
      final item = TodoItem.fromJson(doc);
      item.id = doc['id'];
      filteredTodoItems.add(item);
    }

    filteredTodoItems = filteredTodoItems
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();

    return filteredTodoItems;
  }

  @override
  Future<TodoItem?> getById(String id) async {
    final doc = await collection!.doc(id).get();
    if (doc != null) {
      return TodoItem.fromJson(doc);
    }
    return null;
  }

  @override
  Future<TodoItem> update(String idOfItemToUpdate, TodoItem newItemData) async {
    await collection!.doc(idOfItemToUpdate).set(newItemData.toJson());
    return newItemData;
  }
}
