import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:grsu_guide/galleries/map/leaf_area_of_interest.dart';
import 'package:grsu_guide/galleries/map/relative_area.dart';

import '../map/area_of_interest.dart';
import '../map/parent_area_of_interest.dart';

class AreaOfInterestDto {
  int? placeId;
  String coordinates;
  String shape;
  List<AreaOfInterestDto> childAreas;

  AreaOfInterestDto({
    required this.coordinates,
    required this.shape,
    required this.childAreas,
    this.placeId,
  });

  AreaOfInterest toAreaOfInterest(
    Size originalSize,
    Size renderedSize,
    GlobalKey<State<StatefulWidget>> imageKey,
    TransformationController transformationController,
    TickerProvider tickerProvider,
    void Function(AreaOfInterest) onTapped,
    int? placeId,
  ) {
    final relativeArea = RelativeArea.fromRect(
      _AreaOfInterestCoordinates(coordinates).getRect(),
      originalSize,
      renderedSize,
    );
    if (childAreas.isEmpty) {
      return LeafAreaOfInterest.fromRect(
        relativeArea,
        imageKey,
        onTapped,
        placeId!,
      );
    }

    return ParentAreaOfInterest.fromRect(
      relativeArea,
      imageKey,
      transformationController,
      tickerProvider,
      onTapped,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placeId': placeId,
      'coordinates': coordinates,
      'shape': shape,
      'childAreas': childAreas.map((x) => x.toMap()).toList(),
    };
  }

  factory AreaOfInterestDto.fromMap(Map<String, dynamic> map) {
    return AreaOfInterestDto(
      placeId: map['placeId'] != null ? map['placeId'] as int : null,
      coordinates: map['coordinates'] as String,
      shape: map['shape'] as String,
      childAreas: List<AreaOfInterestDto>.from(
        (map['childAreas'] as List<dynamic>).map<AreaOfInterestDto>(
          (x) => AreaOfInterestDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaOfInterestDto.fromJson(String source) =>
      AreaOfInterestDto.fromMap(json.decode(source) as Map<String, dynamic>);
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
