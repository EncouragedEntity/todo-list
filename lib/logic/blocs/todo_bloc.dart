import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/providers/todo/todo_item_local_provider.dart';
import '../../data/repositories/todo_repository.dart';
import 'events/todo_event.dart';
import 'states/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final repository = TodoRepository(TodoItemLocalProvider());

  TodoBloc() : super(TodoLoadingState()) {
    on<TodoLoadAllItemsEvent>((event, emit) async {
      emit(TodoLoadingState());
      final itemList = await repository.getAll();
      emit(TodoItemsLoadedState(itemList));
    });

    on<TodoLoadAllItemsByTitleEvent>((event, emit) async {
      emit(TodoLoadingState());
      final itemList = await repository.getAllByTitle(event.itemTitle);
      emit(TodoItemsLoadedState(itemList));
    });

    on<TodoAddNewItemEvent>((event, emit) async {
      emit(TodoLoadingState());
      final newItem = event.item;
      await repository.create(newItem);
      final itemList = await repository.getAll();
      emit(TodoItemsLoadedState(itemList));
    });

    on<TodoUpdateItemEvent>((event, emit) async {
      final item = event.item;
      final id = event.idOfItemToUpdate;
      await repository.update(id, item);
    });

    on<TodoRemoveItemEvent>((event, emit) async {
      final itemToRemove = event.item;
      if (itemToRemove.id != null) {
        await repository.delete(itemToRemove.id!);
      }
    });
  }
}
