import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/events/auth_events.dart';
import 'package:todo_list/blocs/states/auth_states.dart';
import 'package:todo_list/repositories/user_repository.dart';

import '../providers/auth/user_local_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticatedState()) {
    final userRepository = UserRepository(UserLocalProvider());

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      final email = event.email;
      final password = event.password;

      final result = await userRepository.logIn(email, password);
      if (result != null) {
        emit(AuthAuthenticatedState());
        return;
      }
      emit(AuthFailureState("Failed to log in"));
    });

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());

      final email = event.email;
      final password = event.password;

      final result = await userRepository.signUp(email, password);
      if (result != null) {
        emit(AuthNotAuthenticatedState());
        return;
      }
      emit(AuthFailureState('Failed to sign up'));
    });

    on<AuthLogoutEvent>(((event, emit) async {
      final logoutResult = await userRepository.logOut();
      if (logoutResult) {
        emit(AuthNotAuthenticatedState());
        return;
      }
    }));
  }
}
