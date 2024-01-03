import 'package:flutter_app/domain/pokemon/model/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList(int limit, int offset);
}
