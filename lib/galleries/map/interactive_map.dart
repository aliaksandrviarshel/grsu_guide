import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:grsu_guide/galleries/map/parent_area_of_interest.dart';
import 'package:grsu_guide/galleries/place.dart';

import 'area_of_interest.dart';

class InteractiveMap {
  final Size _renderedSize;
  final TransformationController _transformationController;
  final void Function(AreaOfInterest) onTapped;
  late final List<AreaOfInterest> _areas;
  set areas(List<AreaOfInterest> areas) => _areas = areas;

  InteractiveMap(
    this._renderedSize,
    this._transformationController,
    this.onTapped,
  );

  void init() {
    const scale = 1.6;
    final x = -_renderedSize.width / 2 * (scale - 1);
    final y = -_renderedSize.height / 2 * (scale - 1);
    _transformationController.value = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);
  }

  void dispose() {
    for (var element in _areas) {
      element.dispose();
    }
  }

  Future<void> tap(TapUpDetails details) async {
    final area =
        _areas.firstWhereOrNull((element) => element.contains(details));
    if (area != null) {
      await area.tap(details);
    }
  }

  bool isZoomed() {
    return _areas.none((element) => element.isZoomed());
  }

  Future<void> zoomOut() {
    return Future.wait(_areas.map((e) => e.zoomOut()));
  }

  ParentAreaOfInterest? getCurrentArea() {
    return _areas.firstWhereOrNull((element) => element.isZoomed())
        as ParentAreaOfInterest?;
  }

  Future<void> zoomToAndTap(Place place) async {
    final area = _areas.firstWhereOrNull((element) => element.has(place));
    if (area != null) {
      await area.imitateTap(place);
    }
  }
}
