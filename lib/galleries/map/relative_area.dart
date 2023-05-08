import 'dart:ui';

class RelativeArea {
  late final Rect _rect;
  Rect get rect => _rect;

  RelativeArea.fromRect(
    Rect originalRect,
    Size originalSize,
    Size renderedSize,
  ) {
    final smallImgHeight = renderedSize.width / originalSize.aspectRatio;
    final topOffset = renderedSize.height / 2 - smallImgHeight / 2;

    final double ratio = renderedSize.width / originalSize.width;
    final double renderedLeft = originalRect.left * ratio;
    final double renderedTop = originalRect.top * ratio;
    final double renderedRight = originalRect.right * ratio;
    final double renderedBottom = originalRect.bottom * ratio;
    _rect =
        Rect.fromLTRB(renderedLeft, renderedTop, renderedRight, renderedBottom)
            .translate(0, topOffset);
  }

  bool contains(Offset localPosition) {
    return _rect.contains(localPosition);
  }
}
