import 'package:cloud_firestore/cloud_firestore.dart';

import 'place_dto.dart';

class PlacesRepository {
  Future<List<PlaceDto>> getPlaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('places').get();
    return querySnapshot.docs
        .map((e) => PlaceDto.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  Future<PlaceDto> getPlace(String placeId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('places')
        .doc(placeId)
        .get();
    var data = documentSnapshot.data();
    return PlaceDto.fromMap(data as Map<String, dynamic>);
  }
}
