import 'package:flutter/material.dart';

import 'package:flutter_app/presentation/feature/pokemon/widget/pagination_widget.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
class MyFavoritesPage extends ConsumerWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;

    final pokemonList = ref.watch(pokemonListViewModelProvider);

    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: BeerListView(pokemonList,),
      ),
    );
  }
}
*/