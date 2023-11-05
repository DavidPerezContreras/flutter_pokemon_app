import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pokemon_list_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PokemonListWidget();
  }
}
