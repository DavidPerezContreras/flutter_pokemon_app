import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/all_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/favorites_page.dart';

import 'package:flutter_app/presentation/feature/pokemon/widget/home_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

ThemeData customTheme = ThemeData(
  // Define the primary color for the app
  primaryColor: Colors.blue,

  // Define the color scheme
  colorScheme: const ColorScheme.light(
    primary: Colors.blue, // Primary color
    secondary: Color.fromARGB(255, 47, 0, 255), // Secondary color
    onPrimary: Colors.white, // Color for texts on primary color
    onSecondary: Colors.white, // Color for texts on secondary color
  ),

  // Define the app bar theme
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 0, 18, 55), // Color for app bar
  ),

  // Define text theme
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      color: Colors.black, // Default text color
    ),
    // Define other text styles like headline, subtitle, etc. if needed
  ),

  // Define button theme
  buttonTheme: ButtonThemeData(
    buttonColor:
        const Color.fromARGB(255, 33, 243, 233), // Default button color
    textTheme: ButtonTextTheme.primary, // Text style for buttons
  ),

  // Define card theme
  cardTheme: CardTheme(
    color: Colors.white, // Color for cards
    elevation: 2.0, // Elevation for cards
  ),

  // Define other theme attributes like icon theme, input decoration, etc. if needed
);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  final ThemeData app = ThemeData.dark(useMaterial3: true);

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: MyNavigationPage(),
    );
  }
}
/*
Widget _allBuilder(BuildContext context, GoRouterState state) {
  return const Directionality(
    textDirection: TextDirection.ltr,
    child: AllPage(),
  );
}

Widget _favoritesBuilder(BuildContext context, GoRouterState state) {
  return const Directionality(
    textDirection: TextDirection.ltr,
    child: FavoritesPage(),
  );
}
*/


/*
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: _allBuilder,
      routes: <RouteBase>[

        GoRoute(path: 'home', builder: _allBuilder),
        GoRoute(path: 'favorites', builder: _favoritesBuilder),
      ],
    ),
  ],
);
*/