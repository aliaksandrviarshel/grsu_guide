import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/galleries/services/place_dto.dart';
import 'package:grsu_guide/galleries/services/places_service.dart';

class Place {
  final String id;
  final String mapId;
  final String imageSrc;
  final String name;
  final String description;
  late bool _isFavorite;
  bool get isFavorite => _isFavorite;
  final PlacesService _placesService = Get.find<PlacesService>();

  Place({
    required this.id,
    required this.mapId,
    required this.imageSrc,
    required this.name,
    required this.description,
    required bool isFavorite,
  }) : _isFavorite = isFavorite;

  factory Place.fromDto(PlaceDto dto) {
    return Place(
      id: dto.id,
      mapId: dto.mapId,
      imageSrc: dto.imageSrc,
      name: dto.name,
      description: dto.description,
      isFavorite: dto.isFavorite,
    );
  }

  Future<void> toggleFavorite() async {
    _isFavorite = await _placesService.toggleFavorite(id);
  }

  Future<void> removeFromFavorites() async {
    await _placesService.removeFromFavorites(id);
  }

  Future<void> navigateToMap(BuildContext context) async {
    print(mapId);
    await Navigator.of(context).pushReplacementNamed(
      '/$mapId',
      arguments: this,
    );
  }
}
