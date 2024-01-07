import 'dart:convert';
import 'package:flutter_app/domain/pokemon/model/pokemon.dart';
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

        List<Future> futures = [];
        for (var i = 0; i < results.length; i++) {
          final pokemonData = results[i];
          String url = pokemonData['url'];
          futures.add(fetchPokemonDetails(url));
        }

        List responses = await Future.wait(futures);

        for (var i = 0; i < responses.length; i++) {
          final pokemonDetails = responses[i];
          int id = pokemonDetails['id'];
          String name = pokemonDetails['name'];
          List<String> abilities = pokemonDetails['abilities']
              .map<String>(
                  (abilityMap) => abilityMap['ability']['name'] as String)
              .toList();
          String officialArtwork = pokemonDetails['sprites']['other']
              ['official-artwork']['front_default'];
          pokemonList.add(Pokemon(id, name, abilities, officialArtwork));
        }
      }

      return pokemonList;
    } else {
      await Future.delayed(const Duration(seconds: 2));
      return await fetchPokemon(
          limit, offset); //aveces la api da error, pues reintenta.
    }
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Pokemon details');
    }
  }
}
