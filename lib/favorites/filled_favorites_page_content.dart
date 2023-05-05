import 'package:flutter/material.dart';

import '../galleries/place.dart';

import 'favorites_page_background.dart';

class FilledFavoritesPageContent extends StatefulWidget {
  final List<Place> places;
  final void Function() onLastPlaceRemoved;

  const FilledFavoritesPageContent(
      {super.key, required this.places, required this.onLastPlaceRemoved});

  @override
  State<FilledFavoritesPageContent> createState() =>
      _FilledFavoritesPageContentState();
}

class _FilledFavoritesPageContentState
    extends State<FilledFavoritesPageContent> {
  late final List<Place> _places;

  @override
  void initState() {
    super.initState();
    _places = widget.places;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const FavoritesPageBackground(isGuideVisible: false),
        Positioned(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xffBFC1E9).withOpacity(0),
                    const Color(0xffBFC1E9),
                    const Color(0xffBFC1E9),
                    const Color(0xffBFC1E9),
                  ]),
              image: const DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(
                  'assets/images/favorites/menu_swipe.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 60),
              child: _FavoritePlacesList(
                places: _places,
                onLastPlaceRemoved: widget.onLastPlaceRemoved,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _FavoritePlacesList extends StatefulWidget {
  final List<Place> places;
  final void Function() onLastPlaceRemoved;

  const _FavoritePlacesList({
    required this.places,
    required this.onLastPlaceRemoved,
  });

  @override
  State<_FavoritePlacesList> createState() => _FavoritePlacesListState();
}

class _FavoritePlacesListState extends State<_FavoritePlacesList> {
  @override
  Widget build(BuildContext context) {
    List<Place> places = widget.places;

    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: places.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (BuildContext context, int index) {
        var item = places[index];
        return _PlaceCard(
          place: item,
          onDismissed: (place) {
            place.removeFromFavorites().then((value) {
              places.removeAt(index);
              if (places.isEmpty) {
                widget.onLastPlaceRemoved();
              }
            });
          },
        );
      },
    );
  }
}

class _PlaceCard extends StatefulWidget {
  final Place place;
  final void Function(Place place) onDismissed;

  const _PlaceCard({required this.place, required this.onDismissed});

  @override
  State<_PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<_PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(widget.place.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => widget.onDismissed(widget.place),
        background: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: const Color(0xffD5D8F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            'assets/icons/favorites/bin.png',
            width: 30,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        width: 88,
                        fit: BoxFit.fitWidth,
                        widget.place.imageSrc,
                      ),
                      Container(
                        height: 88,
                        width: 88,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              Colors.white,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  widget.place.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}
