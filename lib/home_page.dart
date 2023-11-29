import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/blocs/states/auth_states.dart';
import 'package:todo_list/pages/error_page.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:todo_list/pages/todos_page.dart';

import 'pages/loading_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (authCtx, state) {
        if (state is AuthNotAuthenticatedState) {
          return const LoginPage();
        }
        if (state is AuthAuthenticatedState) {
          //! Do not remove this Future
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const TodosPage()),
            );
          });
        }
        if (state is AuthLoadingState) {
          return const LoadingPage();
        }
        if (state is AuthFailureState) {
          return ErrorPage(
            message: 'Failed to log in, try again.\n${state.message}',
          );
        }
        return const LoadingPage();
      },
    );
  }
}
