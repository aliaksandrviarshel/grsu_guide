import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grsu_guide/map/services/map_repository.dart';

import 'map_dto.dart';

class MapFirebaseRepository implements MapRepository {
  @override
  Future<String> getImageSrc(String mapId) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    final mapDto =
        MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return mapDto.imageSrc;
  }

  @override
  Future<MapDto> getMap(
    String mapId,
  ) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('maps').doc(mapId).get();
    return MapDto.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }
}
