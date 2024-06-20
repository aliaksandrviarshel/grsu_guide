import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:grsu_guide/map/bottom_sheet/place.dart';

import '../../_common/dotted_progress_indicator/dotted_progress_indicator.dart';

import 'favorite_button.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    var imageHeight = MediaQuery.of(context).size.height * .4;
    var imageWidth = MediaQuery.of(context).size.width * .6;
    var bottomSheetHeight = MediaQuery.of(context).size.height * .9;

    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: bottomSheetHeight,
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
                          child: Image.network(
                            place.imageSrc,
                            height: imageHeight,
                            width: imageWidth,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return SizedBox(
                                  height: imageHeight,
                                  child: const DottedProgressIndicator());
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.background,
                      constraints: BoxConstraints(
                        // TODO: fix this temporary solution
                        minHeight: bottomSheetHeight - imageHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                place.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: colorScheme.onBackground,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                FavoriteButton(
                                  imageKey: _favoriteButtonKey,
                                  isFavorite: widget.place.isFavorite,
                                  onTap: _onFavoriteButtonTap,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.addToFavorites,
                                  style: TextStyle(
                                    color: colorScheme.onBackground,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place.description,
                              style: TextStyle(color: colorScheme.onBackground),
                            ),
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

  Future<void> _onFavoriteButtonTap() async {
    await widget.place.toggleFavorite();
    setState(() {});
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
