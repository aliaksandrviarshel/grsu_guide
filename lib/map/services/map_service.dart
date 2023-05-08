import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../map/area_of_interest.dart';
import '../map/interactive_map.dart';

import 'map_repository.dart';

class MapService {
  final _mapRepository = Get.find<MapRepository>();

  Future<String> getImageSrc(String mapId) async {
    return _mapRepository.getImageSrc(mapId);
  }

  Future<InteractiveMap> getMap(
    String mapId,
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

    final mapDto = await _mapRepository.getMap(mapId);
    final originalSize = await _getImageSize(mapDto.imageSrc);
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
    Image image = Image.network(assetName);
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
