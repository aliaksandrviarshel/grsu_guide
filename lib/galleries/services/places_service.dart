import 'package:grsu_guide/galleries/services/place_entity.dart';

import '../../main.dart';
import '../place.dart';

class PlacesService {
  Future<List<Place>> getFavoritePlaces() async {
    final places =
        await database.query('places', where: 'isFavorite = ?', whereArgs: [1]);
    return places.map((e) => Place.fromEntity(PlaceEntity.fromMap(e))).toList();
  }

  Future<Place> getPlace(int placeId) async {
    final places =
        await database.query('places', where: 'id = ?', whereArgs: [placeId]);
    final placeMap = places[0];
    var placeDto = PlaceEntity.fromMap(placeMap);
    return Place.fromEntity(placeDto);
  }

  Future<bool> toggleFavorite(int placeId) async {
    final places =
        await database.query('places', where: 'id = ?', whereArgs: [placeId]);
    final entity = PlaceEntity.fromMap(places[0]);
    entity.isFavorite = entity.isFavorite == 1 ? 0 : 1;
    await database.update('places', entity.toMap(),
        where: 'id = ?', whereArgs: [placeId]);
    return entity.isFavorite == 1;
  }

  Future<void> removeFromFavorites(int placeId) async {
    final places =
        await database.query('places', where: 'id = ?', whereArgs: [placeId]);
    final entity = PlaceEntity.fromMap(places[0])..isFavorite = 0;
    await database.update('places', entity.toMap(),
        where: 'id = ?', whereArgs: [placeId]);
  }
}
