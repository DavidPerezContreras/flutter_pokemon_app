import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/home_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      
    );
  }
}

Widget _homeBuilder(BuildContext context, GoRouterState state) {
  return const Directionality(
    textDirection: TextDirection.ltr,
    child: MyHomePage(),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: _homeBuilder,
      routes: <RouteBase>[
        /*GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const MyFavoritesPage();
          },
        ),*/
        GoRoute(path: 'home', builder: _homeBuilder),
      ],
    ),
  ],
);
