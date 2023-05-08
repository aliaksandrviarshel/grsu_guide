import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grsu_guide/galleries/services/place_dto.dart';

import '../place.dart';

class PlacesService {
  Future<List<Place>> getFavoritePlaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('places').get();
    final doc = querySnapshot.docs;
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesIds = prefs.getStringList('favorite_places') ?? [];
    final placeDtos = querySnapshot.docs
        .map((e) => PlaceDto.fromMap(e.data() as Map<String, dynamic>));
    return placeDtos
        .where((element) => favoritePlacesIds.contains(element.id))
        .map((e) => Place.fromDto(e))
        .toList();
  }

  Future<Place> getPlace(String placeId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('places')
        .where('id', isEqualTo: placeId)
        .get();
    var doc = querySnapshot.docs[0];
    var placeDto = PlaceDto.fromMap(doc.data() as Map<String, dynamic>);

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
