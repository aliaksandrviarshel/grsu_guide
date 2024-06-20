import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:grsu_guide/map/services/places_repository.dart';

import '../../settings/app_settings.dart';

import 'place_dto.dart';

class PlacesFirebaseRepository implements PlacesRepository {
  final _settings = Get.find<AppSettings>();
  final _languageCodeCollectionPathMap = {'ru': 'places', 'en': 'places_en'};

  @override
  Future<List<PlaceDto>> getPlaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(_getCollectionPath()).get();
    return querySnapshot.docs
        .map((e) => PlaceDto.fromMap(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<PlaceDto> getPlace(String placeId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(_getCollectionPath())
        .doc(placeId)
        .get();
    var data = documentSnapshot.data();
    return PlaceDto.fromMap(data as Map<String, dynamic>, placeId);
  }

  String _getCollectionPath() {
    final languageCode = _settings.currentLocale.languageCode;
    return _languageCodeCollectionPathMap[languageCode]!;
  }
}
