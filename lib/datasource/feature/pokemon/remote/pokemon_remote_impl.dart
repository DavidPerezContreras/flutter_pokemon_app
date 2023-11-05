import 'dart:convert';
import 'package:flutter_app/model/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRemoteImpl {
  static const String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemon(int limit, int offset) async {

    final response =
        await http.get(Uri.parse('$_baseUrl?limit=$limit&offset=$offset'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Pokemon> pokemonList = <Pokemon>[];
      final decodedData = json.decode(response.body);

      if (decodedData.containsKey('results')) {
        List<dynamic> results = decodedData['results'];

        for (var i = 0; i < results.length; i++) {
          final pokemonData = results[i];
          String name = pokemonData['name'];
          pokemonList.add(Pokemon(offset * limit + i, name));
        }
      }

      //Ejecutamos 10 peticiones de forma asíncrona y esperamos a que acaben todas para obtener los detalles del pokemon

      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon: Results key not found');
    }
  }
}
