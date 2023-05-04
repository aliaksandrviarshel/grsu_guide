import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/nav_wheel.dart';
import 'package:grsu_guide/navigation/navigation_item.dart';
import 'package:grsu_guide/navigation/petal/rotation_handler/left_rotation_handler.dart';

import 'nav_petal.dart';
import 'rotated_petal_controller.dart';
import 'rotation_handler/rotation_handler.dart';

class RotatedPetal extends StatefulWidget {
  final int index;
  final NavigationItem navigationItem;
  final RotationHandler rotationHandler;
  final RotatedPetalsController controller;
  final void Function(
    RotatedPetalState petalState,
    NavigationItem navigationItem,
  ) onTap;

  const RotatedPetal({
    super.key,
    required this.index,
    required this.rotationHandler,
    required this.onTap,
    required this.controller,
    required this.navigationItem,
  });

  @override
  State<RotatedPetal> createState() => RotatedPetalState();
}

class RotatedPetalState extends State<RotatedPetal> {
  late final RotationHandler _handler;

  @override
  void initState() {
    super.initState();
    widget.controller.attach(this);
    _handler = widget.rotationHandler;
  }

  @override
  Widget build(BuildContext context) {
    double petalHeight = MediaQuery.of(context).size.width * .7;
    return AnimatedRotation(
      turns: _handler.turns,
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: const Offset(0, -80),
        child: SizedBox(
          height: petalHeight,
          child: GestureDetector(
            onTap: () => widget.onTap(
              this,
              widget.navigationItem,
            ),
            child: NavPetal(
              isTransparent: isCurrent(),
              title: widget.navigationItem.name,
              icon: SizedBox(
                width: 30,
                child: widget.navigationItem.smallIcon,
              ),
              largeIcon: widget.navigationItem.largeIcon,
              alignment: _handler is LeftRotationHandler
                  ? NavWheelAlignment.left
                  : NavWheelAlignment.right,
            ),
          ),
        ),
      ),
    );
  }

  bool isCurrent() => _handler.isCurrent();

  bool isPrevious() => _handler.isPrevious();

  bool isNext() => _handler.isNext();

  void previous() => _handler.previous();

  void next() => _handler.next();
}
