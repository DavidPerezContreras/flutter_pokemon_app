import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/about_me_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/all_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/favorites_page.dart';

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

  MaterialPageRoute materialAllPageRoute =
      MaterialPageRoute(builder: (BuildContext context) => const AllPage());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("flutter_pokemon_app"),
          //<Widget>[]
          backgroundColor: Colors.greenAccent[400],
          elevation: 50.0,

          systemOverlayStyle: SystemUiOverlayStyle.light,
        ), //AppBar,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navigationIndex,
          onTap: (int index) {
            setState(() {
              _navigationIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'About me',
            ),
          ],
          selectedItemColor: Colors.blue,
        ),
        body: IndexedStack(
          index: _navigationIndex,
          children: const [AllPage(), FavoritesPage(), AboutMePage()],
        ));
  }
}
