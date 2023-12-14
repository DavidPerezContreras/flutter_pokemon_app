import 'dart:convert';
import 'package:flutter_app/model/pokemon.dart';
import 'package:http/http.dart' as http;

//ESTO TAMBIÉN LO HICE A LO PERRO. haceos un mapper
class PokemonRemoteImpl {
  static const String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemon(int limit, int offset) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?limit=$limit&offset=$offset'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Hay veces que símplemente el servidor va a fallar por algún motibo. para reintentar en caso de error ver clausula del throw
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

      //Lo que yo haría ahora es hacer 10 peticiones de forma asíncrona y esperamos a que acaben todas para obtener los 10 detalles
      //Luego generamos el modelo completo. con todos los detalles. Hacer esto en vez de hacerlo de forma síncrona,
      //Permite que traigamos todos los datos al mismo tiempo, en vez de esperar a tener uno para pedir el siguiente.
      //Por la "race condition" no podríamos controlar el orden en el que se reciben pero, si podemos conservar el orden
      //Ved Future.wait(<Future>[])
      return pokemonList;
    } else {
      return fetchPokemon(
          limit, offset); //Recursividad hasta que de un status code 200-299
    }
  }
}
