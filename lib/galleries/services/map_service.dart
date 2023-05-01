import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../map/area_of_interest.dart';
import '../map/interactive_map.dart';

import 'map_dto.dart';

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
    final map = InteractiveMap(
      renderedSize,
      transformationController,
      onTapped,
    );

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
              map,
            ))
        .toList();
    map.areas = areas;
    return map;
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
