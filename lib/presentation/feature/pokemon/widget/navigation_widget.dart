import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/about_me_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/all_page.dart';

class MyNavigationPage extends StatefulWidget {
  const MyNavigationPage(this.themeNotifier, {Key? key}) : super(key: key);
  final ValueNotifier<ThemeData> themeNotifier;
  @override
  State<MyNavigationPage> createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int _navigationIndex = 0;
  late List<Page<dynamic>> pages;
  List<String> items = ['Home', 'About'];
  MaterialPageRoute materialAllPageRoute =
      MaterialPageRoute(builder: (BuildContext context) => const AllPage());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navigationIndex,
          onTap: (int index) {
            setState(() {
              _navigationIndex = index;
            });
          },
          items: List.generate(items.length, (index) {
            return BottomNavigationBarItem(
              icon: Icon(index == 0 ? Icons.home : Icons.person),
              label: items[index],
            );
          }),
          selectedItemColor: Colors.blue,
        ),
        body: IndexedStack(
          index: _navigationIndex,
          children: const [AllPage(), AboutMePage()],
        ));
  }
}
