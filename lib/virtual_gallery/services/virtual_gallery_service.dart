import 'package:cloud_firestore/cloud_firestore.dart';

import 'picture_dto.dart';

class VirtualGalleryService {
  Future<List<PictureDto>> getPictures() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('vr_gallery').get();
    return querySnapshot.docs
        .map((e) => PictureDto.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
}
