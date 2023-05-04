import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/navigation_item.dart';
import 'package:grsu_guide/navigation/petal/rotation_handler/left_rotation_handler.dart';
import 'package:grsu_guide/navigation/petal/rotation_handler/rotation_handler.dart';

import 'petal/petal_sizer.dart';
import 'petal/rotated_petal.dart';
import 'petal/rotated_petal_controller.dart';
import 'petal/rotation_handler/right_rotation_handler.dart';

enum NavWheelAlignment { left, right }

class NavWheel extends StatefulWidget {
  final NavWheelAlignment alignment;

  const NavWheel({super.key, this.alignment = NavWheelAlignment.left});

  @override
  State<NavWheel> createState() => _NavWheelState();
}

class _NavWheelState extends State<NavWheel> with TickerProviderStateMixin {
  final _petalsController = RotatedPetalsController();
  final _navItems = [
    NavigationItem.fromRoute(Routes.galleriesMap),
    NavigationItem.fromRoute(Routes.academicBuildings),
    NavigationItem.fromRoute(Routes.libraries),
    NavigationItem.fromRoute(Routes.favorites),
    NavigationItem.fromRoute(Routes.cafes),
    NavigationItem.fromRoute(Routes.dormitories),
    NavigationItem.fromRoute(Routes.architecture),
    NavigationItem.fromRoute(Routes.leisure),
    NavigationItem.fromRoute(Routes.artStores),
    NavigationItem.fromRoute(Routes.virtualGallery),
    NavigationItem.fromRoute(Routes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final shiftedIndexes = _getShiftedIndexes(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Transform.translate(
      offset: _getOffset(screenWidth, context),
      child: Stack(
        children: [
          for (var index in shiftedIndexes)
            RotatedPetal(
              index: index,
              navigationItem: _navItems[index],
              rotationHandler: _createRotationHandler(
                  _getDisplayIndex(shiftedIndexes, index)),
              controller: _petalsController,
              onTap: _onPetalTap,
            )
        ],
      ),
    );
  }

  List<int> _getShiftedIndexes(BuildContext context) {
    final indexOffset = _navItems.indexWhere((e) => e.isCurrent(context));
    if (widget.alignment == NavWheelAlignment.left) {
      return List.generate(11, (index) => index).shift(4 - indexOffset);
    }

    return List.generate(11, (index) => index).shift(4 - indexOffset + 6);
  }

  Offset _getOffset(double screenWidth, BuildContext context) {
    if (widget.alignment == NavWheelAlignment.left) {
      return Offset(-PetalSizer(context: context).size.width / 2, 124);
    }

    return Offset(
      (screenWidth + PetalSizer(context: context).size.width) / 2 - 8,
      124,
    );
  }

  void _onPetalTap(
    RotatedPetalState petalState,
    NavigationItem navigationItem,
  ) {
    if (petalState.isCurrent()) {
      navigationItem.navigate(context);
      return;
    }

    petalState.isPrevious()
        ? _petalsController.previous()
        : _petalsController.next();

    setState(() {});
  }

  int _getDisplayIndex(List<int> list, int i) {
    return list.shift(-2)[i];
  }

  RotationHandler _createRotationHandler(int petalDisplayIndex) {
    return widget.alignment == NavWheelAlignment.left
        ? LeftRotationHandler(displayIndex: petalDisplayIndex)
        : RightRotationHandler(displayIndex: petalDisplayIndex);
  }
}

extension ListExtension<T> on List<T> {
  List<T> shift(int k) {
    final n = length;
    final shift = k % n;
    if (shift == 0) return this;
    if (shift < 0) {
      return [...sublist(n + shift), ...sublist(0, n + shift)];
    } else {
      return [...sublist(shift), ...sublist(0, shift)];
    }
  }
}
