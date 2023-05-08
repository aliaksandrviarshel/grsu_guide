import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../settings/app_settings.dart';

import 'picture_dto.dart';

class VirtualGalleryRepository {
  final _settings = Get.find<AppSettings>();
  final _languageCodeCollectionPathMap = {
    'ru': 'vr_gallery',
    'en': 'vr_gallery_en'
  };

  Future<List<PictureDto>> getPictures() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(_getCollectionPath()).get();
    return querySnapshot.docs
        .map((e) => PictureDto.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  String _getCollectionPath() {
    final languageCode = _settings.currentLocale.languageCode;
    return _languageCodeCollectionPathMap[languageCode]!;
  }
}
