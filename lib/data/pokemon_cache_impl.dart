import 'package:flutter_app/domain/pokemon/model/pokemon.dart';

class PokemonCacheImpl {
  List<Pokemon> pokemonCacheList = [];
  List<Pokemon> getPokemonList(int limit, int offset) {
    List<Pokemon> cachePokemonSubList =
        pokemonCacheList.sublist(offset, offset + limit);
    return cachePokemonSubList;
  }

  void appendPokemonList(List<Pokemon> pokemonList) {}
}
