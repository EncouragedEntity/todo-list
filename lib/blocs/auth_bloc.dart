import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/events/auth_events.dart';
import 'package:todo_list/blocs/states/auth_states.dart';
import 'package:todo_list/providers/auth/mock_user_provider.dart';
import 'package:todo_list/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticatedState()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      final email = event.email;
      final password = event.password;

      final result =
          await UserRepository(MockUserProvider()).logIn(email, password);
      if (result) {
        emit(AuthAuthenticatedState());
        return;
      }
      emit(AuthFailureState("Failed to log in"));
    });

    on<AuthSignUpEvent>((event, emit) {});
  }
}
