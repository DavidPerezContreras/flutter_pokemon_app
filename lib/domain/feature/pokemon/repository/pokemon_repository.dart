import 'package:flutter_app/model/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList(int limit, int offset);
}
