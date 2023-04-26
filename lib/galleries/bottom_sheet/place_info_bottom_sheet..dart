import 'package:flutter/material.dart';

import 'package:grsu_guide/galleries/place.dart';

// TODO: favorite places functionality (have to identificate places by id)
class PlaceInfoBottomSheet extends StatefulWidget {
  final Place place;

  const PlaceInfoBottomSheet({super.key, required this.place});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  final _favoriteButtonKey = GlobalKey();
  var _markerPosition = 0.0;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: may be try to remove this kostyl, bruh
    _scrollController.addListener(_setMarkerPosition);
    // TODO: move logic of binding a positioned widget to separate widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMarkerPosition();
    });
    final place = widget.place;

    return SingleChildScrollView(
      child: Container(
        color: const Color(0xffcccde1),
        height: MediaQuery.of(context).size.height * .9,
        child: Stack(
          children: [
            Positioned(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 30,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                          child: Image.asset(place.imageSrc),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xffE9E4F9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                place.name,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Image.asset(
                                  key: _favoriteButtonKey,
                                  'assets/icons/favorite_inactive.png',
                                ),
                                const SizedBox(width: 8),
                                const Text('Добавить в избранное')
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(place.description)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: _markerPosition,
              child: Image.asset('assets/images/map_marker.png'),
            )
          ],
        ),
      ),
    );
  }

  void _setMarkerPosition() {
    if (_favoriteButtonKey.currentState == null) {
      return;
    }

    final renderBox = _favoriteButtonKey.currentState?.context
        .findRenderObject() as RenderBox;
    final newPosition = MediaQuery.of(context).size.height -
        renderBox.localToGlobal(Offset.zero).dy;
    if (newPosition != _markerPosition) {
      _markerPosition = newPosition;
      setState(() {});
    }
  }
}