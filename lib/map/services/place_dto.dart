import 'dart:convert';

class PlaceDto {
  String id;
  String mapId;
  String imageSrc;
  String name;
  String description;
  bool isFavorite;

  PlaceDto({
    required this.id,
    required this.imageSrc,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.mapId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mapId': mapId,
      'imageSrc': imageSrc,
      'name': name,
      'description': description,
      'isFavorite': isFavorite,
    };
  }

  factory PlaceDto.fromMap(Map<String, dynamic> map, String placeId) {
    return PlaceDto(
      id: placeId,
      mapId: map['mapId'] as String,
      imageSrc: map['imageSrc'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
