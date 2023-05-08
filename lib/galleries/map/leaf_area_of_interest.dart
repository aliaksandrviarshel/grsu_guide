import 'package:flutter/widgets.dart';

import 'package:grsu_guide/galleries/place.dart';

import 'area_of_interest.dart';
import 'relative_area.dart';

class LeafAreaOfInterest implements AreaOfInterest {
  final String placeId;
  final GlobalKey _imageKey;
  final void Function(LeafAreaOfInterest) onTapped;

  final RelativeArea _relativeArea;

  @override
  bool get isLeaf => true;

  LeafAreaOfInterest.fromRect(
    this._relativeArea,
    this._imageKey,
    this.onTapped,
    this.placeId,
  );

  @override
  dispose() {
    // empty implementation
  }

  @override
  Future<void> tap(TapUpDetails details) async {
    onTapped(this);
  }

  @override
  bool contains(TapUpDetails details) {
    RenderBox box = _imageKey.currentContext!.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    return _relativeArea.contains(localPosition);
  }

  @override
  bool isZoomed() => false;

  @override
  Future<void> zoomOut() async {
    // empty implementation
  }

  @override
  bool has(Place place) => place.id == placeId;

  @override
  Future<void> imitateTap(Place place) async {
    onTapped(this);
  }
}
