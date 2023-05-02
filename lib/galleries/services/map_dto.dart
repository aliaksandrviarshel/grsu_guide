import 'dart:convert';

import 'area_of_interest_dto.dart';

class MapDto {
  String imageSrc;
  List<AreaOfInterestDto> areas;

  MapDto({
    required this.areas,
    required this.imageSrc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageSrc': imageSrc,
      'areas': areas.map((x) => x.toMap()).toList(),
    };
  }

  factory MapDto.fromMap(Map<String, dynamic> map) {
    return MapDto(
      imageSrc: map['imageSrc'] as String,
      areas: List<AreaOfInterestDto>.from(
        (map['areas'] as List<dynamic>).map<AreaOfInterestDto>(
          (x) => AreaOfInterestDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapDto.fromJson(String source) =>
      MapDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
