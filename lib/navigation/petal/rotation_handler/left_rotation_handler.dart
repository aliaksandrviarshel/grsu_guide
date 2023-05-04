import 'rotation_handler.dart';

class LeftRotationHandler implements RotationHandler {
  final _turn = 1 / 12;
  late double _turns;
  late int _displayIndex;
  var _offset = 0;

  final int _initialDisplayIndex;

  LeftRotationHandler({required int displayIndex})
      : _initialDisplayIndex = displayIndex,
        _displayIndex = displayIndex {
    _initTurns();
  }

  @override
  double get turns => _turns;

  @override
  bool isCurrent() {
    return _displayIndex == 2;
  }

  @override
  bool isPrevious() {
    return _displayIndex < 2;
  }

  @override
  bool isNext() {
    return _displayIndex > 2;
  }

  @override
  void previous() {
    _offset++;
    _changeDisplayedIndex();
    if (_displayIndex == 2 || _displayIndex == 3) {
      _turns += _turn * 1.5;
      return;
    }

    _turns += _turn;
  }

  @override
  void next() {
    _offset--;
    _changeDisplayedIndex();
    if (_displayIndex == 1 || _displayIndex == 2) {
      _turns -= _turn * 1.5;
      return;
    }

    _turns -= _turn;
  }

  void _changeDisplayedIndex() {
    const length = 11;
    int index = (_initialDisplayIndex + _offset) % length;
    if (index < 0) {
      index += length;
    }

    _displayIndex = index;
  }

  void _initTurns() {
    if (_initialDisplayIndex == 0 || _initialDisplayIndex == 1) {
      _turns = _turn * (_initialDisplayIndex + .5);
      return;
    }

    if (_initialDisplayIndex == 2) {
      _turns = _turn * 3;
      return;
    }

    _turns = _turn * (_initialDisplayIndex + 1.5);
  }
}
