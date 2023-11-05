import 'package:flutter_app/domain/feature/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_app/model/pokemon.dart';

class GetPokemonUseCase {
  GetPokemonUseCase({required this.pokemonRepository});

  Future<List<Pokemon>> getPokemonListUseCase(int limit, int offset) async {
    return pokemonRepository.getPokemonList(limit, offset);
  }

  PokemonRepository pokemonRepository;
}
