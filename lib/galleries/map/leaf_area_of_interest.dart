import 'package:flutter/widgets.dart';

import 'area_of_interest.dart';
import 'relative_area.dart';

class LeafAreaOfInterest implements AreaOfInterest {
  final int placeId;
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
  dispose() {}

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
  Future<void> zoomOut() async {}

  // TODO: remove function duplication in areas of interest
  Rect _convertRect(Rect originalRect, Size originalSize, Size renderedSize) {
    final double ratioX = renderedSize.width / originalSize.width;
    final double ratioY = renderedSize.height / originalSize.height;

    final double renderedLeft = originalRect.left * ratioX;
    final double renderedTop = originalRect.top * ratioY;
    final double renderedRight = originalRect.right * ratioX;
    final double renderedBottom = originalRect.bottom * ratioY;

    return Rect.fromLTRB(
      renderedLeft,
      renderedTop,
      renderedRight,
      renderedBottom,
    );
  }
}
