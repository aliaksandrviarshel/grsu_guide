import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

class AreaOfInterest {
  final String? placeId;
  final Rect _originalRect;
  final Size _originalSize;
  final Size _renderedSize;
  final List<AreaOfInterest>? _childAreas;
  final GlobalKey _imageKey;
  final TransformationController _transformationController;
  final TickerProvider _tickerProvider;
  late final AnimationController _animationController;
  late final Rect _areaOfInterest;
  var _isZoomed = false;
  final _defaultScale = 1.7;
  final _targetScale = 3.0;
  final void Function(AreaOfInterest) onTapped;

  late Matrix4Tween _tween;

  bool get isLeaf => _childAreas?.isEmpty ?? true;

  AreaOfInterest.fromRect(
    this._originalRect,
    this._originalSize,
    this._renderedSize,
    this._imageKey,
    this._transformationController,
    this._tickerProvider,
    this.onTapped,
    this.placeId, [
    this._childAreas,
  ]) {
    _animationController = AnimationController(
      vsync: _tickerProvider,
      duration: const Duration(milliseconds: 300),
    );
    _areaOfInterest = _convertRect(
      _originalRect,
      _originalSize,
      _renderedSize,
    );

    _animationController.addListener(
      () {
        _transformationController.value = _tween.evaluate(_animationController);
      },
    );
  }

  dispose() {
    _animationController.dispose();
  }

  Future<void> tap(TapUpDetails details) async {
    if (_childAreas?.isEmpty ?? true) {
      onTapped(this);
      return;
    }

    if (!_isZoomed) {
      onTapped(this);
      await _zoomIn();
      _isZoomed = true;
      return;
    }

    final area = _childAreas?.firstWhereOrNull((x) => x.contains(details));
    if (area == null) {
      onTapped(this);
      _isZoomed = false;
      await _zoomDefault();
      return;
    }

    area.tap(details);
    return;
  }

  bool contains(TapUpDetails details) {
    RenderBox box = _imageKey.currentContext!.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    return _areaOfInterest.contains(localPosition);
  }

  bool isZoomed() => _isZoomed;

  Future<void> zoomOut() async {
    if (!_isZoomed) {
      return;
    }

    await _zoomDefault();
    _isZoomed = false;
  }

  Future<void> _zoomIn() {
    _tween = Matrix4Tween(
      begin: _transformationController.value,
      end: _getZoomedMatrix(),
    );
    _animationController.reset();
    return _animationController.forward();
  }

  Future<void> _zoomDefault() {
    _tween = Matrix4Tween(
      begin: _transformationController.value,
      end: _getDefaultMatrix(),
    );
    _animationController.reset();
    return _animationController.forward();
  }

  // TODO: fix zoom to a point
  Matrix4 _getZoomedMatrix() {
    final x = -_areaOfInterest.left * (_targetScale - 1);
    final y = -_areaOfInterest.center.dy * (_targetScale - 1);
    final matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(_targetScale);
    return matrix;
  }

  Matrix4 _getDefaultMatrix() {
    final renderedSize = _imageKey.currentContext!.size!;
    final x = -renderedSize.width / 2 * (_defaultScale - 1);
    final y = -renderedSize.height / 2 * (_defaultScale - 1);
    final matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(_defaultScale);
    return matrix;
  }

  Rect _convertRect(Rect originalRect, Size originalSize, Size renderedSize) {
    final double ratioX = renderedSize.width / originalSize.width;
    final double ratioY = renderedSize.height / originalSize.height;

    final double renderedLeft = originalRect.left * ratioX;
    final double renderedTop = originalRect.top * ratioY;
    final double renderedRight = originalRect.right * ratioX;
    final double renderedBottom = originalRect.bottom * ratioY;

    return Rect.fromLTRB(
        renderedLeft, renderedTop, renderedRight, renderedBottom);
  }
}
