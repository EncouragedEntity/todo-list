import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/states/todo_state.dart';
import 'package:todo_list/providers/todo/todo_mock_provider.dart';
import 'package:todo_list/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final mockProvider = TodoMockProvider();

  TodoBloc() : super(TodoLoadingState()) {
    on<TodoLoadAllItemsEvent>((event, emit) async {
      emit(TodoLoadingState());
      final itemList = await TodoRepository(mockProvider)
          .getAll(); //TODO Change to normal provider
      emit(TodoItemsLoadedState(itemList));
    });

    on<TodoAddNewItemEvent>((event, emit) async {
      emit(TodoLoadingState());
      final newItem = event.item;
      await TodoRepository(mockProvider).create(newItem);
      final itemList = await TodoRepository(mockProvider).getAll();
      emit(TodoItemsLoadedState(itemList));
    });
  }
}
