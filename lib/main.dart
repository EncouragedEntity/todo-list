import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/auth_bloc.dart';
import 'package:todo_list/blocs/todo_bloc.dart';
import 'package:todo_list/home_page.dart';
import 'package:todo_list/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: appTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext ctx) => AuthBloc(),
          ),
          BlocProvider(
            create: (BuildContext ctx) => TodoBloc(),
          ),
        ],
        child: const HomePage(),
      ),
    ),
  );
}
