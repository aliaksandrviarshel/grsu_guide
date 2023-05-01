import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:grsu_guide/galleries/map/relative_area.dart';

import 'area_of_interest.dart';

class ParentAreaOfInterest implements AreaOfInterest {
  final List<AreaOfInterest> _childAreas;
  final GlobalKey _imageKey;
  final TransformationController _transformationController;
  final TickerProvider _tickerProvider;
  late final AnimationController _animationController;
  var _isZoomed = false;
  final _defaultScale = 1.7;
  final _targetScale = 3.0;
  final void Function(AreaOfInterest) onTapped;

  final RelativeArea _relativeArea;
  late Matrix4Tween _tween;

  @override
  bool get isLeaf => false;

  ParentAreaOfInterest.fromRect(
    this._relativeArea,
    this._imageKey,
    this._transformationController,
    this._tickerProvider,
    this.onTapped,
    this._childAreas,
  ) {
    _animationController = AnimationController(
      vsync: _tickerProvider,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.addListener(
      () {
        _transformationController.value = _tween.evaluate(_animationController);
      },
    );
  }

  @override
  dispose() {
    _animationController.dispose();
  }

  @override
  Future<void> tap(TapUpDetails details) async {
    if (!_isZoomed) {
      onTapped(this);
      await _zoomIn();
      _isZoomed = true;
      return;
    }

    final area = _childAreas.firstWhereOrNull((x) => x.contains(details));
    if (area == null) {
      onTapped(this);
      _isZoomed = false;
      await _zoomDefault();
      return;
    }

    area.tap(details);
    return;
  }

  @override
  bool contains(TapUpDetails details) {
    RenderBox box = _imageKey.currentContext!.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    return _relativeArea.contains(localPosition);
  }

  @override
  bool isZoomed() => _isZoomed;

  @override
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
    final x = -_relativeArea.rect.left * (_targetScale - 1);
    final y = -_relativeArea.rect.center.dy * (_targetScale - 1);
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
}
