import 'package:flutter_app/data/pokemon_cache_impl.dart';
import 'package:flutter_app/datasource/feature/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_app/domain/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_app/domain/pokemon/model/pokemon.dart';

class PokemonDataImpl implements PokemonRepository {
  const PokemonDataImpl(
      {required this.pokemonRemoteImpl, required this.pokemonCacheImpl});

  final PokemonRemoteImpl pokemonRemoteImpl;
  final PokemonCacheImpl pokemonCacheImpl;

  @override
  Future<List<Pokemon>> getPokemonList(int limit, int offset) async {
    List<Pokemon> remotePokemonList =
        await pokemonRemoteImpl.fetchPokemon(limit, offset);
    return remotePokemonList;
  }
}
