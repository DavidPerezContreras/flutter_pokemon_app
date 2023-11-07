import 'package:flutter/material.dart';
import 'package:flutter_app/di/dependency_injection.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/page/favorites_page.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pagination_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PokemonListWidget extends ConsumerStatefulWidget {
  PokemonListWidget(
      {super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListWidgetState();
}

class _PokemonListWidgetState extends ConsumerState<PokemonListWidget> {
  var _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    //En este caso comparten viewmodel porque tienen una función muy parecida
    //La lógica de negocio es la misma, solo cambia la forma en la que
    //Estos datos se presentan.

    final pokemonList = ref.watch(pokemonListViewModelProvider).pokemonList;


    final viewModel = ref.watch(pokemonListViewModelProvider.notifier);

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: BeerListView(pokemonList, viewModel),
    );
  }
}
