import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../area_of_interest.dart';

import 'map_service.dart';

class AreaOfInterestDto {
  String? placeId;
  String coordinates;
  String shape;
  List<AreaOfInterestDto> childAreas;

  AreaOfInterestDto({
    required this.coordinates,
    required this.shape,
    required this.childAreas,
    this.placeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coordinates': coordinates,
      'shape': shape,
      'childAreas': childAreas.map((x) => x.toMap()).toList(),
      'placeId': placeId,
    };
  }

  factory AreaOfInterestDto.fromMap(Map<String, dynamic> map) {
    return AreaOfInterestDto(
      coordinates: map['coordinates'] as String,
      shape: map['shape'] as String,
      placeId: map['placeId'] as String?,
      childAreas: List<AreaOfInterestDto>.from(
        (map['childAreas'] as List<dynamic>).map<AreaOfInterestDto>(
          (x) => AreaOfInterestDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaOfInterestDto.fromJson(String source) {
    return AreaOfInterestDto.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  AreaOfInterest toAreaOfInterest(
    Size originalSize,
    Size renderedSize,
    GlobalKey<State<StatefulWidget>> imageKey,
    TransformationController transformationController,
    TickerProvider tickerProvider,
    void Function(AreaOfInterest) onTapped,
    String? placeId,
  ) {
    return AreaOfInterest.fromRect(
      _AreaOfInterestCoordinates(coordinates).getRect(),
      originalSize,
      renderedSize,
      imageKey,
      transformationController,
      tickerProvider,
      onTapped,
      placeId,
      childAreas
          .map((e) => e.toAreaOfInterest(
                originalSize,
                renderedSize,
                imageKey,
                transformationController,
                tickerProvider,
                onTapped,
                e.placeId,
              ))
          .toList(),
    );
  }
}

class _AreaOfInterestCoordinates {
  final String _coordinates;

  _AreaOfInterestCoordinates(
    this._coordinates,
  );

  getRect() {
    var coordinates = _coordinates.split(',').map(double.parse).toList();
    return Rect.fromLTRB(
      coordinates[0],
      coordinates[1],
      coordinates[2],
      coordinates[3],
    );
  }
}
