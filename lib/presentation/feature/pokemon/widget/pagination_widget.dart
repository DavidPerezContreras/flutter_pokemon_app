import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  const BeerListView(List<Pokemon> pokemonList, this.viewModel, {super.key});
  final PokemonListViewModel viewModel;
  @override
  BeerListViewState createState() => BeerListViewState();
}

class BeerListViewState extends State<BeerListView> {
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
      //final newItems = List.generate(
      //    pageSize, (index) => Pokemon( pageKey.toInt() + index));

      final newItems = await widget.viewModel.getPokemonUseCase
          .getPokemonListUseCase(_pageSize, pageKey);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;

        if (nextPageKey - newItems.length <= 1292) {
          //
          _pagingController.appendPage(newItems, nextPageKey);
        }
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
      Consumer(
        builder: (context, ref, child) {
          return PagedListView<int, Pokemon>(
            
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Pokemon>(
              itemBuilder: (context, item, index) => PokemonListItem(
                pokemon: item,
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class PokemonListItem extends StatefulWidget {
  const PokemonListItem({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<PokemonListItem> createState() => _PokemonListItemState();
}

class _PokemonListItemState extends State<PokemonListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomExpandableTileCard(
                  pokemon: widget.pokemon,
                  key: widget.key,
                ));
  }
}

class CustomExpandableTileCard extends StatefulWidget {
  CustomExpandableTileCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();

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
        final id = widget.pokemon.id;
        final name = widget.pokemon.name;

        Color cardColor = Theme.of(context).cardColor;
        Color darkCardColor = Color.fromARGB(255, cardColor.red - 10,
            cardColor.green - 10, cardColor.blue - 10);

        return PageStorage(
          bucket: pageStorageBucket,
          child: ExpansionTileCard(
            baseColor: darkCardColor,
            key: widget.cardA,
            leading: Container(
                color: cardColor,
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                    imageUrl:
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id + 1}.png")),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(name),
            children: <Widget>[
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
