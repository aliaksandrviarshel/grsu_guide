import 'package:flutter/widgets.dart';

abstract class AreaOfInterest {
  bool get isLeaf;
  dispose();
  Future<void> tap(TapUpDetails details);
  bool contains(TapUpDetails details);
  bool isZoomed();
  Future<void> zoomOut();
}
