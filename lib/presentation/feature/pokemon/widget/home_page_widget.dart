import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/about_me_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/all_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/favorites_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pokemon_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class MyNavigationPage extends StatefulWidget {
  MyNavigationPage({Key? key}) : super(key: key);

  @override
  _MyNavigationPageState createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int _navigationIndex = 0;
  late List<Page<dynamic>> pages;

  MaterialPageRoute materialAllPageRoute= MaterialPageRoute(builder: (BuildContext context)=> const AllPage());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    switch(_navigationIndex){
      case 0:
    pages = [
      MaterialPage(child: AllPage()),
      MaterialPage(child: FavoritesPage()),
      MaterialPage(child: AboutMePage()),
    ];
      break;
      case 1:
    pages = [
      MaterialPage(child: AllPage()),
      MaterialPage(child: FavoritesPage()),
      MaterialPage(child: AboutMePage()),
    ];
      break;
      case 2:
    pages = [
      MaterialPage(child: AllPage()),
      MaterialPage(child: FavoritesPage()),
      MaterialPage(child: AboutMePage()),
    ];
      break;
    }
    pages = [
      MaterialPage(child: AllPage()),
      MaterialPage(child: FavoritesPage()),
      MaterialPage(child: AboutMePage()),
    ];


    return Scaffold(
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
        children: [AllPage(),FavoritesPage(),AboutMePage()],)
    );
  }
}
