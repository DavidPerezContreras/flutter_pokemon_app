import 'package:flutter/material.dart';
import 'package:flutter_app/domain/pokemon/usecase/get_pokemon_usecase.dart';
import 'package:flutter_app/domain/pokemon/model/pokemon.dart';

class PokemonListViewModel extends ChangeNotifier {
  PokemonListViewModel({required this.getPokemonUseCase});
  final GetPokemonUseCase getPokemonUseCase;

  List<Pokemon> pokemonList = [];

  Future<void> fetchPokemon(int limit, int offset) async {
    pokemonList = await getPokemonUseCase.getPokemonListUseCase(limit, offset);
    notifyListeners();
  }
}
