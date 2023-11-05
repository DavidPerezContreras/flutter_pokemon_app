import 'package:flutter_app/data/pokemon_data_impl.dart';
import 'package:flutter_app/datasource/feature/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_app/domain/feature/pokemon/usecase/get_pokemon_usecase.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//PROVIDED CACHE
class PokemonListViewModel extends StateNotifier<List<Pokemon>> {
  PokemonListViewModel({required this.getPokemonUseCase}) : super([]);
  GetPokemonUseCase getPokemonUseCase;

  void setPokemonList(List<Pokemon> pokemonList) {
    state = pokemonList;
  }

  Future<void> fetchPokemon(int limit, int offset) async {
    state = await getPokemonUseCase.getPokemonListUseCase(limit, offset);
  }
}

//DEPENDENCY INJECTION
final pokemonListViewModelProvider =
    StateNotifierProvider<PokemonListViewModel, List<Pokemon>>(
  (ref) {
    return PokemonListViewModel(
      getPokemonUseCase: GetPokemonUseCase(
        pokemonRepository: PokemonDataImpl(
          pokemonRemoteImpl: PokemonRemoteImpl(),
        ),
      ),
    );
  },
);
