import 'package:flutter/material.dart';
import 'package:flutter_app/data/pokemon_cache_impl.dart';
import 'package:flutter_app/data/pokemon_data_impl.dart';
import 'package:flutter_app/datasource/feature/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_app/domain/pokemon/usecase/get_pokemon_usecase.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pagination_widget.dart';

class NavigationWidget extends StatefulWidget {
  NavigationWidget({super.key});

  final PokemonListViewModel pokemonListViewModel = PokemonListViewModel(
    getPokemonUseCase: GetPokemonUseCase(
      pokemonRepository: PokemonDataImpl(
        pokemonRemoteImpl: PokemonRemoteImpl(),
        pokemonCacheImpl: PokemonCacheImpl(),
      ),
    ),
  );

  @override
  State<NavigationWidget> createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widget.key,
      width: double.infinity,
      height: double.infinity,
      child: BeerListView(widget.pokemonListViewModel),
    );
  }
}
