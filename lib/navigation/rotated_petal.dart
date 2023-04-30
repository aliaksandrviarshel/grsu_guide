import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/navigation_item.dart';

import 'nav_petal.dart';
import 'rotated_petal_controller.dart';

class RotatedPetal extends StatefulWidget {
  const RotatedPetal({
    super.key,
    required this.index,
    required this.displayIndex,
    required this.onTap,
    required this.controller,
    required this.navigationItem,
  });

  final int index;
  final NavigationItem navigationItem;
  final int displayIndex;
  final RotatedPetalsController controller;
  final void Function(
    int index,
    int displayIndex,
    NavigationItem navigationItem,
  ) onTap;

  @override
  State<RotatedPetal> createState() => RotatedPetalState();
}

class RotatedPetalState extends State<RotatedPetal> {
  final _turn = 1 / 12;
  late double _turns;
  late int _displayIndex;
  var _offset = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.attach(this);
    _initTurns();
    _displayIndex = widget.displayIndex;
  }

  @override
  Widget build(BuildContext context) {
    double petalHeight = MediaQuery.of(context).size.width * .7;
    return AnimatedRotation(
      turns: _turns,
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: const Offset(0, -80),
        child: SizedBox(
          height: petalHeight,
          child: GestureDetector(
            onTap: () => widget.onTap(
              widget.index,
              _displayIndex,
              widget.navigationItem,
            ),
            child: NavPetal(
              isTransparent: _displayIndex == 2,
              title: widget.navigationItem.name,
              icon: SizedBox(
                width: 30,
                child: widget.navigationItem.smallIcon,
              ),
              largeIcon: widget.navigationItem.largeIcon,
            ),
          ),
        ),
      ),
    );
  }

  void _initTurns() {
    if (widget.displayIndex == 0 || widget.displayIndex == 1) {
      _turns = _turn * (widget.displayIndex + .5);
      return;
    }

    if (widget.displayIndex == 2) {
      _turns = _turn * 3;
      return;
    }

    _turns = _turn * (widget.displayIndex + 1.5);
  }

  void previous() {
    _offset++;
    _changeDisplayedIndex();
    if (_displayIndex == 2 || _displayIndex == 3) {
      _turns += _turn * 1.5;
      return;
    }

    _turns += _turn;
  }

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
    int index = (widget.displayIndex + _offset) % length;
    if (index < 0) {
      index += length;
    }

    _displayIndex = index;
  }
}
