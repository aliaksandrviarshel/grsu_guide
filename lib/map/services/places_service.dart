import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_sheet/place.dart';

import 'places_repository.dart';

class PlacesService {
  final _placesRepository = Get.find<PlacesRepository>();

  Future<List<Place>> getFavoritePlaces() async {
    final placeDtos = await _placesRepository.getPlaces();
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesIds = prefs.getStringList('favorite_places') ?? [];
    return placeDtos
        .where((element) => favoritePlacesIds.contains(element.id))
        .map((e) => Place.fromDto(e))
        .toList();
  }

  Future<Place> getPlace(String placeId) async {
    final placeDto = await _placesRepository.getPlace(placeId);
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesIds = prefs.getStringList('favorite_places') ?? [];
    placeDto.isFavorite = favoritePlacesIds.contains(placeId);
    return Place.fromDto(placeDto);
  }

  Future<bool> toggleFavorite(String placeId) async {
    final place = await getPlace(placeId);
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesIds = prefs.getStringList('favorite_places') ?? [];
    if (place.isFavorite) {
      favoritePlacesIds.remove(placeId);
    } else {
      favoritePlacesIds.addIf(!favoritePlacesIds.contains(placeId), placeId);
    }

    await prefs.setStringList('favorite_places', favoritePlacesIds);
    return !place.isFavorite;
  }

  Future<void> removeFromFavorites(String placeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesIds = prefs.getStringList('favorite_places') ?? [];
    favoritePlacesIds.remove(placeId);

    await prefs.setStringList('favorite_places', favoritePlacesIds);
  }
}
