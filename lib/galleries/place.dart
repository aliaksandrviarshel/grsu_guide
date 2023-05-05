import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/galleries/services/place_entity.dart';
import 'package:grsu_guide/galleries/services/places_service.dart';

class Place {
  final int id;
  final String imageSrc;
  final String name;
  final String description;
  late bool _isFavorite;
  bool get isFavorite => _isFavorite;
  final PlacesService _placesService = Get.find<PlacesService>();

  Place({
    required this.id,
    required this.imageSrc,
    required this.name,
    required this.description,
    required bool isFavorite,
  }) : _isFavorite = isFavorite;

  factory Place.fromEntity(PlaceEntity entity) {
    return Place(
      id: entity.id,
      imageSrc: entity.imageSrc,
      name: entity.name,
      description: entity.description,
      isFavorite: entity.isFavorite == 1,
    );
  }

  Future<void> toggleFavorite() async {
    _isFavorite = await _placesService.toggleFavorite(id);
  }

  Future<void> removeFromFavorites() async {
    await _placesService.removeFromFavorites(id);
  }

  Future<void> navigateToMap(BuildContext context) async {
    // TODO: change logic when a new map will be added
    await Navigator.of(context).pushReplacementNamed(
      '/galleries_map',
      arguments: this,
    );
  }
}
