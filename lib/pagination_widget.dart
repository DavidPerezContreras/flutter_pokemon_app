import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  static const _pageSize = 10;

  final PagingController<int, BeerSummary> _pagingController =
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
          pageSize, (index) => BeerSummary(index: pageKey.toInt() + index));
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
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
      PagedListView<int, BeerSummary>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<BeerSummary>(
          itemBuilder: (context, item, index) => BeerListItem(
            beer: item,
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class BeerSummary {
  int index;

  BeerSummary({required this.index});
}

class BeerListItem extends StatefulWidget {
  BeerListItem({super.key, required this.beer});

  BeerSummary beer;

  @override
  State<BeerListItem> createState() => _BeerListItemState();
}

class _BeerListItemState extends State<BeerListItem> {
  @override
  Widget build(BuildContext context) {
    Color lightTileColumn = Theme.of(context).colorScheme.primary;
    Color darkTileColumn = Color.fromARGB(255, lightTileColumn.red + 100,
        lightTileColumn.green + 100, lightTileColumn.blue + 100);

    final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Container(child: CustomExpandableTileCard(key: widget.key,))
    );
  }
}

class CustomExpandableTileCard extends StatefulWidget {
  
   CustomExpandableTileCard({super.key});
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
    return PageStorage(
      bucket: pageStorageBucket,
      child: ExpansionTileCard(
        key: widget.cardA,
        leading:  SizedBox(height:100,width:100, child: CachedNetworkImage(imageUrl: "https://img.fruugo.com/product/4/02/350353024_max.jpg")),
        title: const Text('Tap me!'),
        subtitle: const Text('I expand!'),
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
  }
}
