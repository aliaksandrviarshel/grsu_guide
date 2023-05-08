import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../map/area_of_interest.dart';
import '../map/interactive_map.dart';

import 'map_dto.dart';

class MapService {
  Future<String> getImageSrc(String mapId) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    final mapDto =
        MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return mapDto.imageSrc;
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

    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    final mapDto =
        MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);

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
