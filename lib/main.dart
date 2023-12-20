import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_list/app_widget.dart';

void main() {
  final widgets = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgets);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppWidget());
  FlutterNativeSplash.remove();
}
