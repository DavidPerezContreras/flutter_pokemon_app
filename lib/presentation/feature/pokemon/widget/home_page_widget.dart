import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/about_me_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/all_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/favorites_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pokemon_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyNavigationPage extends StatefulWidget {
  MyNavigationPage({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  var _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (int index) {
          setState(() {
            _navigationIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.push(
                  widget.navigatorKey.currentContext!,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AllPage()));
              break;

            case 1:
              Navigator.push(
                  widget.navigatorKey.currentContext!,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const FavoritesPage()));
              break;

            case 2:
              Navigator.push(
                  widget.navigatorKey.currentContext!,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AboutMePage()));
              break;
            default:
              Center(
                child: Text("Error: Page not found"),
              );
          }
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
      appBar: AppBar(
        title: Text(_navigationIndex.toString()),
        backgroundColor: Colors.blue, // Customize the app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Action for search icon
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Action for settings icon
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Navigator(
          key: widget.navigatorKey,
          onPopPage: (route, result) => route.didPop(result),
          pages: [MaterialPage(child: AllPage())]),
    );
  }
}
