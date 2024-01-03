import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/navigation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    themeNotifier.addListener(() {
      setState(
        () {},
      );
    });
    super.initState();
  }

  ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier<ThemeData>(ThemeData.dark());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: widget.key,
      theme: themeNotifier.value,
      debugShowCheckedModeBanner: false,
      home: MyNavigationPage(themeNotifier),
    );
  }
}
