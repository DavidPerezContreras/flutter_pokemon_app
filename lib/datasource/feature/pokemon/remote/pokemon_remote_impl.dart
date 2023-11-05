import 'dart:convert';
import 'package:flutter_app/model/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRemoteImpl {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemon(int limit, int offset) async {
    print("remote impl called");

    final response = await http.get(Uri.parse('$_baseUrl?limit=$limit&offset=$offset'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("200");
      List<Pokemon> pokemonList=<Pokemon>[];
      final decodedData = json.decode(response.body);

      if (decodedData.containsKey('results')) {
        List<dynamic> results = decodedData['results'];
        
        for (var i = 0; i < results.length; i++) {
          final pokemonData= results[i];
          String name = pokemonData['name'];
          String url = pokemonData['url'];
          pokemonList.add( Pokemon(offset*limit+i,name));
        }
        }

        return pokemonList;
      } else {
        throw Exception('Failed to load Pokémon: Results key not found');
      }

  }
}