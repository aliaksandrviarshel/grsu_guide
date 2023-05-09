import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:grsu_guide/map/bottom_sheet/place.dart';
import 'package:grsu_guide/map/map/leaf_area_of_interest.dart';
import 'package:grsu_guide/map/map/relative_area.dart';

import 'area_of_interest.dart';
import 'interactive_map.dart';

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
  final InteractiveMap _map;
  final RelativeArea _relativeArea;
  late Matrix4Tween _tween;

  @override
  Rect get rect => _relativeArea.rect;

  @override
  bool get isLeaf => false;

  ParentAreaOfInterest.fromRect(
    this._relativeArea,
    this._imageKey,
    this._transformationController,
    this._tickerProvider,
    this.onTapped,
    this._childAreas,
    this._map,
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
      if (!_map.isZoomed()) {
        return;
      }

      onTapped(this);
      await _zoomIn();
      return;
    }

    final area = _childAreas.firstWhereOrNull((x) => x.contains(details));
    if (area == null) {
      onTapped(this);
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
  bool has(Place place) {
    final area = _childAreas.firstWhereOrNull((element) => element.has(place));
    return area != null;
  }

  @override
  Future<void> imitateTap(Place place) async {
    final area = _childAreas.firstWhereOrNull((element) => element.has(place));
    if (area != null) {
      await _zoomIn();
      area.imitateTap(place);
    }
  }

  @override
  Future<void> zoomOut() async {
    if (_isZoomed) {
      await _zoomDefault();
    }
  }

  Future<void> _zoomIn() async {
    _tween = Matrix4Tween(
      begin: _transformationController.value,
      end: _getZoomedMatrix(),
    );
    _animationController.reset();
    await _animationController.forward();
    _isZoomed = true;
  }

  Future<void> _zoomDefault() async {
    _tween = Matrix4Tween(
      begin: _transformationController.value,
      end: _getDefaultMatrix(),
    );
    _animationController.reset();
    await _animationController.forward();
    _isZoomed = false;
  }

  Matrix4 _getZoomedMatrix() {
    double smallX = getXOffset();
    final x = _relativeArea.rect.center.dx - smallX;
    final y = _relativeArea.rect.center.dy;
    final matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(_targetScale)
      ..translate(-x, -y);
    return matrix;
  }

  double getXOffset() {
    final renderedSize = _imageKey.currentContext!.size!;
    final bigWidth = renderedSize.width;
    final rect = _relativeArea.rect;

    final bigX = (bigWidth - _relativeArea.rect.center.dx) / 2;
    final percentage = bigX / bigWidth;
    return rect.width *
        percentage *
        (bigWidth / 2 - _relativeArea.rect.left).sign;
  }

  double getYOffset() {
    final renderedSize = _imageKey.currentContext!.size!;
    final bigHeight = renderedSize.height;
    final bigY = (renderedSize.height - _relativeArea.rect.center.dy) / 2;
    final percentage = bigY / renderedSize.height;
    return _relativeArea.rect.height *
        percentage *
        (bigHeight / 2 - _relativeArea.rect.center.dx).sign;
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

  @override
  List<LeafAreaOfInterest> getLeafAreas() {
    return _childAreas
        .where((element) => element.isLeaf)
        .cast<LeafAreaOfInterest>()
        .toList();
  }
}
