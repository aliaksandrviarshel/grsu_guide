import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'area_of_interest.dart';

class InteractiveMap {
  final List<AreaOfInterest> _areas;
  final Size _renderedSize;
  final TransformationController _transformationController;
  final void Function(AreaOfInterest) onTapped;

  InteractiveMap(
    this._areas,
    this._renderedSize,
    this._transformationController,
    this.onTapped,
  ) {
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
}
