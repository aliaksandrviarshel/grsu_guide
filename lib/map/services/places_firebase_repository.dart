import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grsu_guide/map/services/places_repository.dart';

import 'place_dto.dart';

class PlacesFirebaseRepository implements PlacesRepository {
  @override
  Future<List<PlaceDto>> getPlaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('places').get();
    return querySnapshot.docs
        .map((e) => PlaceDto.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PlaceDto> getPlace(String placeId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('places')
        .doc(placeId)
        .get();
    var data = documentSnapshot.data();
    return PlaceDto.fromMap(data as Map<String, dynamic>);
  }
}
