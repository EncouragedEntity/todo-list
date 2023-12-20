import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/home_page.dart';
import 'package:todo_list/pages/todos_page.dart';
import 'package:todo_list/theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AuthBloc _authBloc = AuthBloc();
  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: appTheme,
      routes: {
        '/': (context) =>
            BlocProvider.value(value: _authBloc, child: const HomePage()),
        '/todos': (context) =>
            BlocProvider.value(value: _authBloc, child: const TodosPage()),
      },
    );
  }
}
