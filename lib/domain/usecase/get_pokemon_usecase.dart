import 'package:flutter_app/domain/usecase/repository/pokemon_repository.dart';
import 'package:flutter_app/model/pokemon.dart';

class GetPokemonUseCase {



  //Now that the requests are being made 100 TIMES!! (CHECK PAGING),
  //we should store it in the cache and read always from memory first if possible.



  GetPokemonUseCase({required this.pokemonRepository});

  Future<List<Pokemon>> getPokemonListUseCase(int limit, int offset)async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("delayed");
    return pokemonRepository.getPokemonList(limit, offset);
  }

  PokemonRepository pokemonRepository;
}
