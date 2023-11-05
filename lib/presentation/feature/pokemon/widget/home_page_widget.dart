import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pagination_widget.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pokemon_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

        return PokemonListWidget();
      
    
  }
}
