import 'dart:convert';

class PlaceEntity {
  int id;
  String imageSrc;
  String name;
  String description;
  int isFavorite;

  PlaceEntity({
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

  factory PlaceEntity.fromMap(Map<String, dynamic> map) {
    return PlaceEntity(
      id: map['id'] as int,
      imageSrc: map['imageSrc'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      isFavorite: map['isFavorite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceEntity.fromJson(String source) =>
      PlaceEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
