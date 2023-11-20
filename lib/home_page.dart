import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/blocs/states/auth_states.dart';
import 'package:todo_list/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (authCtx, state) {
        if (state is AuthNotAuthenticatedState) {
          return const LoginPage();
        }
        return const Text("Something's wrong...");
      },
    );
  }
}
