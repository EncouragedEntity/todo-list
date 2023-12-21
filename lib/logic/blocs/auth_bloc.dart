import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstore/localstore.dart';
import 'package:todo_list/logic/blocs/events/auth_events.dart';
import 'package:todo_list/logic/blocs/states/auth_states.dart';

import '../../data/providers/auth/user_local_provider.dart';
import '../../data/repositories/user_repository.dart';
import '../models/auth/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticatedState()) {
    final userRepository = UserRepository(UserLocalProvider());

    on<AuthAutomaticLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      final savedCredentials =
          await Localstore.instance.collection('currentUser').doc('user').get();

      if (savedCredentials != null) {
        final savedUser = User.fromJson(savedCredentials);
        final userResult =
            await userRepository.logIn(savedUser.email, savedUser.password);

        if (userResult != null) {
          emit(AuthAuthenticatedState());
          return;
        }
      }
      emit(AuthNotAuthenticatedState());
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      final email = event.email;
      final password = event.password;

      final userResult = await userRepository.logIn(email, password);
      if (userResult != null) {
        await Localstore.instance
            .collection('currentUser')
            .doc('user')
            .set(userResult.toJson());
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
        await Localstore.instance.collection('currentUser').delete();

        emit(AuthNotAuthenticatedState());
        return;
      }
    }));
  }
}
