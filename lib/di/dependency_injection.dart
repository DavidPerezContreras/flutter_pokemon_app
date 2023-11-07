//DEPENDENCY INJECTION / Coordinator
import 'package:flutter_app/data/pokemon_data_impl.dart';
import 'package:flutter_app/datasource/feature/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_app/domain/feature/pokemon/usecase/get_pokemon_usecase.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonListViewModelProvider =
    ChangeNotifierProvider<PokemonListViewModel>(
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
