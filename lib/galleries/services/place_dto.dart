import 'dart:convert';

class PlaceDto {
  String id;
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageSrc': imageSrc,
      'name': name,
      'description': description,
      'isFavorite': isFavorite,
    };
  }

  factory PlaceDto.fromMap(Map<String, dynamic> map) {
    return PlaceDto(
      id: map['id'] as String,
      imageSrc: map['imageSrc'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDto.fromJson(String source) => PlaceDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
