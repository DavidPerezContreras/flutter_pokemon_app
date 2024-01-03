import 'package:flutter_app/domain/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_app/domain/pokemon/model/pokemon.dart';

class GetPokemonUseCase {
  GetPokemonUseCase({required this.pokemonRepository});
  final PokemonRepository pokemonRepository;

  Future<List<Pokemon>> getPokemonListUseCase(int limit, int offset) async {
    return pokemonRepository.getPokemonList(limit, offset);
  }
}
