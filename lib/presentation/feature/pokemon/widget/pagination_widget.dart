import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/pokemon/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/viewmodel/pokemon_list_viewmodel.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PokemonListWidget extends StatefulWidget {
  const PokemonListWidget(this.viewModel, {super.key});
  final PokemonListViewModel viewModel;
  @override
  State<PokemonListWidget> createState() => PokemonListWidgetState();
}

class PokemonListWidgetState extends State<PokemonListWidget> {
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
  const CustomExpandableTileCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<CustomExpandableTileCard> createState() =>
      _CustomExpandableTileCardState();
}

class _CustomExpandableTileCardState extends State<CustomExpandableTileCard> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  final pageStorageBucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    final name = capitalize(widget.pokemon.name);

    return PageStorage(
      key: Key(widget.pokemon.id.toString()),
      bucket: pageStorageBucket,
      child: Card(
        color: const Color.fromARGB(255, 225, 226, 236),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          tilePadding: const EdgeInsets.all(0),
          trailing: const SizedBox.shrink(),
          backgroundColor: const Color.fromARGB(255, 225, 226, 236),
          title: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
            color: Colors.grey,
            height: 80,
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          leading: SizedBox(
              key: widget.key,
              height: 200,
              width: 100,
              child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return const Center(
                      child: SizedBox(
                          height: 38,
                          width: 38,
                          child: CircularProgressIndicator()),
                    );
                  },
                  fit: BoxFit.fitHeight,
                  key: widget.key,
                  imageUrl: widget.pokemon.officialArtwork)),
          children: <Widget>[
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: [
                  for (var item in widget.pokemon.abilities)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: Container(
                        color: const Color.fromARGB(50, 255, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          capitalize(item),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 84, 84, 84),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
          onExpansionChanged: (bool expanded) {},
        ),
      ),
    );
  }
}
