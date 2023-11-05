import 'package:flutter_app/datasource/feature/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_app/domain/usecase/repository/pokemon_repository.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonDataImpl implements PokemonRepository {

  const PokemonDataImpl({required this.pokemonRemoteImpl});

  final PokemonRemoteImpl pokemonRemoteImpl;

  //Con un provider le damos a varias vistar el mismo objeto


  @override
  Future<List<Pokemon>> getPokemonList(int limit, int offset) async {
    return pokemonRemoteImpl.fetchPokemon(limit, offset);
  }


}

