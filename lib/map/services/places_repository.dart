import 'place_dto.dart';

abstract class PlacesRepository {
  Future<List<PlaceDto>> getPlaces();
  Future<PlaceDto> getPlace(String placeId);
}
