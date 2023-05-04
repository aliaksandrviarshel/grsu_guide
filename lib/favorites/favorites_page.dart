import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/_common/back_button/back_button.dart';
import 'package:grsu_guide/galleries/place.dart';
import 'package:grsu_guide/galleries/services/places_service.dart';

import '../_common/guide/tour_guide_full_height.dart';
import '../navigation/app_drawer_factory.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _placesService = Get.find<PlacesService>();
  late List<Place> _places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6DAF0),
      drawer: Get.find<AppDrawerFactory>().drawer(),
      endDrawer: Get.find<AppDrawerFactory>().endDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: AppBackButton(
          onPressed: () =>
              // TODO: remove hardcoded routing
              Navigator.of(context).pushReplacementNamed('/galleries_map'),
        ),
      ),
      body: FutureBuilder(
          future: _placesService.getFavoritePlaces(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            _places = snapshot.data!;
            return _places.isEmpty
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      const _Background(),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 320,
                          width: MediaQuery.of(context).size.width,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 120.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: const _AddPlaceButton(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      const _Background(isGuideVisible: false),
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
                              onLastPlaceRemoved: () => setState(() {}),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          }),
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
        return PlaceCard(
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

class PlaceCard extends StatefulWidget {
  final Place place;
  final void Function(Place place) onDismissed;

  const PlaceCard({super.key, required this.place, required this.onDismissed});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
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

class _AddPlaceButton extends StatelessWidget {
  const _AddPlaceButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: remove hardcoded routing
        Navigator.of(context).pushReplacementNamed('/galleries_map');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all(
          const Color(0xff383838),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(88),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
      child: const Text(
        'Добавить место',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final bool isGuideVisible;

  const _Background({this.isGuideVisible = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Избранное',
                style: TextStyle(fontSize: 24),
              ),
              Text('Места, в которые хочется вернуться')
            ],
          ),
        ),
        if (isGuideVisible) const Expanded(child: TourGuideFullHeight()),
      ],
    );
  }
}
