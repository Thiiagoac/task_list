import 'package:flutter/material.dart';
import 'package:task_list/login/login_page.dart';
import 'package:task_list/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: appTheme(),
      home: LoginPage(),
    );
  }
}
