import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/logic/blocs/auth_bloc.dart';
import 'package:todo_list/logic/blocs/events/auth_events.dart';
import 'package:todo_list/theme.dart';

import 'home_page.dart';
import 'pages/todos_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AuthBloc _authBloc = AuthBloc();
  @override
  void initState() {
    super.initState();
    _authBloc.add(const AuthAutomaticLoginEvent());
  }

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
