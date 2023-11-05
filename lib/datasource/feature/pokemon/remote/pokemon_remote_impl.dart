
import 'package:flutter_app/model/pokemon.dart';

class PokemonRemoteImpl{
  Future<List<Pokemon>> fetchPokemon(int limit, int offset) async{
    print("remote impl called");

    if (offset>=10){return [];}
    return Future.value(List.generate(limit, (index) => Pokemon(offset+index)));
  }
}