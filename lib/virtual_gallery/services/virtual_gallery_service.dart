import 'dart:convert';

import 'package:flutter/services.dart';

import 'picture_dto.dart';

class VirtualGalleryService {
  Future<List<PictureDto>> getPictures() async {
    final jsonString =
        await rootBundle.loadString('assets/images/vr_gallery/pictures.json');
    final List<dynamic> duh = json.decode(jsonString);
    return duh.map((e) => PictureDto.fromMap(e)).toList();
  }
}
