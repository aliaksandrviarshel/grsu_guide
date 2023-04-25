import 'dart:convert';

import 'area_of_interest_dto.dart';

class MapDto {
  List<AreaOfInterestDto> areas;

  MapDto({
    required this.areas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'areas': areas.map((x) => x.toMap()).toList(),
    };
  }

  factory MapDto.fromMap(Map<String, dynamic> map) {
    var list = List<AreaOfInterestDto>.from(
      (map['areas'] as List<dynamic>).map<AreaOfInterestDto>(
        (x) => AreaOfInterestDto.fromMap(x as Map<String, dynamic>),
      ),
    );
    return MapDto(
      areas: list,
    );
  }

  String toJson() => json.encode(toMap());

  factory MapDto.fromJson(String source) =>
      MapDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
