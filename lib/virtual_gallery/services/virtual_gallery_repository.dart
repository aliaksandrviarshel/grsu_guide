import 'picture_dto.dart';

abstract class VirtualGalleryRepository {
  Future<List<PictureDto>> getPictures();
}
