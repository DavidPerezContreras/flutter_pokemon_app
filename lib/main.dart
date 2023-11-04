import 'package:flutter/material.dart';
import 'package:flutter_app/home_page_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  ThemeData app = ThemeData.dark();

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MyHomePage(key: widget.key),
    );
  }
}




