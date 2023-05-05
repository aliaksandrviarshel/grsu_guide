import 'package:flutter/widgets.dart';

import 'package:grsu_guide/galleries/place.dart';

abstract class AreaOfInterest {
  bool get isLeaf;
  dispose();
  Future<void> tap(TapUpDetails details);
  bool contains(TapUpDetails details);
  bool isZoomed();
  Future<void> zoomOut();
  bool has(Place place);
  Future<void> imitateTap(Place place);
}
