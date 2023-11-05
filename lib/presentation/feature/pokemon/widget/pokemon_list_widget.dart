import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pagination_widget.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonListWidget extends ConsumerWidget {
  const PokemonListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;

    //En este caso comparten viewmodel porque tienen una función muy parecida
    //La lógica de negocio es la misma, solo cambia la forma en la que
    //Estos datos se presentan.

    final pokemonList = ref.watch(pokemonListViewModelProvider);
    final viewModel = ref.watch(pokemonListViewModelProvider.notifier);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About me',
          ),
        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        //onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text("flutter_pokemon_app"),
        backgroundColor: Colors.blue, // Customize the app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Action for search icon
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Action for settings icon
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: BeerListView(pokemonList, viewModel),
      ),
    );
  }
}
