import 'map_dto.dart';

abstract class MapRepository {
  Future<String> getImageSrc(String mapId);
  Future<MapDto> getMap(String mapId);
}
