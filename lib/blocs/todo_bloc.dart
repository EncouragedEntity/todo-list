import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/events/todo_event.dart';
import 'package:todo_list/blocs/states/todo_state.dart';
import 'package:todo_list/providers/todo/todo_mock_provider.dart';
import 'package:todo_list/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoadingState()) {
    on<TodoLoadAllItemsEvent>((event, emit) async {
      emit(TodoLoadingState());
      final itemList = await TodoRepository(TodoMockProvider())
          .getAll(); //TODO Change to normal provider
      emit(TodoItemsLoadedState(itemList));
    });
  }
}
