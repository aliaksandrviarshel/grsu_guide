import 'dart:ui';

class RelativeArea {
  late final Rect _rect;
  Rect get rect => _rect;

  RelativeArea.fromRect(
    Rect originalRect,
    Size originalSize,
    Size renderedSize,
  ) {
    final double ratioX = renderedSize.width / originalSize.width;
    final double ratioY = renderedSize.height / originalSize.height;

    final double renderedLeft = originalRect.left * ratioX;
    final double renderedTop = originalRect.top * ratioY;
    final double renderedRight = originalRect.right * ratioX;
    final double renderedBottom = originalRect.bottom * ratioY;

    _rect =
        Rect.fromLTRB(renderedLeft, renderedTop, renderedRight, renderedBottom);
  }

  bool contains(Offset localPosition) {
    return _rect.contains(localPosition);
  }
}
