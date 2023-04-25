import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:grsu_guide/galleries/interactive_map.dart';

import '../area_of_interest.dart';
import '../place.dart';

import 'map_dto.dart';
import 'place_dto.dart';

class MapService {
  Future<String> getImageSrc(String mapId) {
    return Future.sync(() => 'assets/images/galleries/map.png');
  }

  Future<InteractiveMap> getMap(
    Size renderedSize,
    GlobalKey<State<StatefulWidget>> imageKey,
    TransformationController transformationController,
    TickerProvider tickerProvider,
    void Function(AreaOfInterest) onTapped,
  ) async {
    final jsonString =
        await rootBundle.loadString('assets/maps/galleries.json');
    var mapDto = MapDto.fromJson(jsonString);
    final originalSize = await _getImageSize('assets/images/galleries/map.png');
    final areas = mapDto.areas
        .map((e) => e.toAreaOfInterest(
              originalSize,
              renderedSize,
              imageKey,
              transformationController,
              tickerProvider,
              onTapped,
              e.placeId,
            ))
        .toList();

    return InteractiveMap(
      areas,
      renderedSize,
      transformationController,
      onTapped,
    );
  }

  Future<Place> getPlace(String placeId) async {
    final jsonString = await rootBundle.loadString('assets/maps/places.json');
    final places = json.decode(jsonString) as List<dynamic>;
    final decodedPlaces = places.map((e) => PlaceDto.fromMap(e));
    final place = decodedPlaces.firstWhere((e) => e.id == placeId);
    return place.toPlace();
  }

  Future<Size> _getImageSize(String assetName) {
    Completer<Size> completer = Completer();
    Image image = Image.asset(assetName);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(
            Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ),
          );
        },
      ),
    );
    return completer.future;
  }
}
