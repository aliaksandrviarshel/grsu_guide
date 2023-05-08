import 'package:cloud_firestore/cloud_firestore.dart';

import 'map_dto.dart';

class MapRepository {
  Future<String> getImageSrc(String mapId) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    final mapDto =
        MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return mapDto.imageSrc;
  }

  Future<MapDto> getMap(
    String mapId,
  ) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    return MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }
}
