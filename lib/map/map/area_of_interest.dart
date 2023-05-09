import 'package:flutter/widgets.dart';

import 'package:grsu_guide/map/bottom_sheet/place.dart';
import 'package:grsu_guide/map/map/leaf_area_of_interest.dart';

abstract class AreaOfInterest {
  Rect get rect;
  bool get isLeaf;
  dispose();
  Future<void> tap(TapUpDetails details);
  bool contains(TapUpDetails details);
  bool isZoomed();
  Future<void> zoomOut();
  bool has(Place place);
  Future<void> imitateTap(Place place);
  List<LeafAreaOfInterest> getLeafAreas();
}
