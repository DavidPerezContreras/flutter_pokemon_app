import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

class BeerListView extends StatefulWidget {
  const BeerListView(List<Pokemon> pokemonList, {super.key});

  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  static const _pageSize = 10;

  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _pageSize);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey, pageSize) async {
    try {
      //final newItems = await RemoteApi.getBeerList(pageKey, _pageSize);
      final newItems = List.generate(
          pageSize, (index) => Pokemon( pageKey.toInt() + index));
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;

        if(nextPageKey-newItems.length<100)//
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, item, index) => PokemonListItem(
            pokemon: item,
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}



class PokemonListItem extends StatefulWidget {
  PokemonListItem({super.key, required this.pokemon});

  Pokemon pokemon;

  @override
  State<PokemonListItem> createState() => _PokemonListItemState();
}

class _PokemonListItemState extends State<PokemonListItem> {
  @override
  Widget build(BuildContext context) {
    Color lightTileColumn = Theme.of(context).colorScheme.primary;
    Color darkTileColumn = Color.fromARGB(255, lightTileColumn.red + 100,
        lightTileColumn.green + 100, lightTileColumn.blue + 100);

    //final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
    //final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

    var screenSize = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: CustomExpandableTileCard(pokemon: widget.pokemon,
          key: widget.key,
        )));
  }
}

class CustomExpandableTileCard extends StatefulWidget {
  CustomExpandableTileCard({super.key,required this.pokemon});

  Pokemon pokemon;

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  @override
  State<CustomExpandableTileCard> createState() =>
      _CustomExpandableTileCardState();
}

class _CustomExpandableTileCardState extends State<CustomExpandableTileCard> {
  final pageStorageBucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final pokemonList = ref.watch(pokemonListViewModelProvider);
        final pokemonListViewModel = ref.read(pokemonListViewModelProvider.notifier);
        final id=widget.pokemon.id;
        return PageStorage(
          bucket: pageStorageBucket,
          child: ExpansionTileCard(
            key: widget.cardA,
            leading: SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                    imageUrl:
                        "https://img.fruugo.com/product/4/02/350353024_max.jpg")),
            title:  Text('Tap me!'+id.toString()),
            subtitle: const Text('I expand!'),
            children: <Widget>[
              ElevatedButton(onPressed: () {
                pokemonListViewModel.fetchPokemon(10, 0);
              }, child: child),
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
      
      Use me any time you think your app could benefit from being just a bit more Material.
      
      These buttons control the next card down!""",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
