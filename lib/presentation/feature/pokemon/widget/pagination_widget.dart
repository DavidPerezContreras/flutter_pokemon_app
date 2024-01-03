import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  const BeerListView(this.viewModel, {super.key});
  final PokemonListViewModel viewModel;
  @override
  State<BeerListView> createState() => BeerListViewState();
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
      final newItems = await widget.viewModel.getPokemonUseCase
          .getPokemonListUseCase(_pageSize, pageKey);

      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage([]);
      } else {
        final nextPageKey = pageKey + newItems.length;

        //
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Pokemon>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Pokemon>(
        itemBuilder: (context, item, index) => PokemonListItem(
          pokemon: item,
        ),
      ),
    );
  }

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
    final id = widget.pokemon.id;
    final name = widget.pokemon.name;

    Color cardColor = Theme.of(context).cardColor;
    Color darkCardColor = Color.fromARGB(
        255, cardColor.red - 10, cardColor.green - 10, cardColor.blue - 10);

    return PageStorage(
      key: widget.key,
      bucket: pageStorageBucket,
      child: ExpansionTileCard(
        baseColor: darkCardColor,
        key: widget.cardA,
        leading: Container(
            key: widget.key,
            color: cardColor,
            height: 100,
            width: 100,
            child: CachedNetworkImage(
                key: widget.key,
                imageUrl:
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id + 1}.png")),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(key: widget.key, name),
        children: <Widget>[
          Divider(
            key: widget.key,
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            key: widget.key,
            alignment: Alignment.centerLeft,
            child: Padding(
              key: widget.key,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                key: widget.key,
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
  }
}
