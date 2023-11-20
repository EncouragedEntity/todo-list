import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/events/auth_events.dart';
import 'package:todo_list/blocs/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticatedState()) {
    on<AuthLoginEvent>((event, emit) {});

    on<AuthSignUpEvent>((event, emit) {});
  }
}
