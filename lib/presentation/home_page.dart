import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/logic/blocs/auth_bloc.dart';
import 'package:todo_list/logic/blocs/states/auth_states.dart';
import 'package:todo_list/presentation/pages/loading_page.dart';
import 'package:todo_list/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (authCtx, state) {
        if (state is AuthNotAuthenticatedState) {
          return const LoginPage(
            isLoginMode: true,
          );
        }
        if (state is AuthAuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/todos', (route) => false);
          });
        }
        if (state is AuthLoadingState) {
          return const LoadingPage();
        }
        if (state is AuthFailureState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(authCtx).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
          return const LoginPage();
        }
        return const LoadingPage();
      },
    );
  }
}
