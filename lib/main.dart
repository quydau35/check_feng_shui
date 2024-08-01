import 'package:check_feng_shui/scaffold/mainscreenscaffold.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check phong thủy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Check phong thủy',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold();
  }
}
