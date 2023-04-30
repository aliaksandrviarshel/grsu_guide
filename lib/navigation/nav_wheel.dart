import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/navigation_item.dart';

import 'rotated_petal.dart';
import 'rotated_petal_controller.dart';

class NavWheel extends StatefulWidget {
  const NavWheel({super.key});

  @override
  State<NavWheel> createState() => _NavWheelState();
}

class _NavWheelState extends State<NavWheel> with TickerProviderStateMixin {
  double get _petalHeight => MediaQuery.of(context).size.width * .7;
  double get _petalWidth => _petalHeight * _petalAspectRatio;
  double get _petalAspectRatio => 150 / 250;
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
    final indexOffset =
        _navItems.indexWhere((element) => element.isCurrent(context));
    final shiftList =
        _shiftList(List.generate(11, (index) => index), 4 - indexOffset);
    return Transform.translate(
      offset: Offset(-_petalWidth / 2, 124),
      child: Stack(
        children: [
          for (var i in shiftList)
            RotatedPetal(
              index: i,
              navigationItem: _navItems[i],
              displayIndex: _getDisplayIndex(shiftList, i),
              controller: _petalsController,
              onTap: _onPetalTap,
            )
        ],
      ),
    );
  }

  void _onPetalTap(int index, int displayIndex, NavigationItem navigationItem) {
    if (displayIndex < 2) {
      _petalsController.previous();
      setState(() {});
      return;
    }

    if (displayIndex > 2) {
      _petalsController.next();
      setState(() {});
      return;
    }

    navigationItem.navigate(context);
  }

  int _getDisplayIndex(List<int> list, int i) {
    return _shiftList(list, -2)[i];
  }

  List<int> _shiftList(List<int> list, int k) {
    final n = list.length;
    final shift = k % n;
    if (shift == 0) return list;
    if (shift < 0) {
      return [...list.sublist(n + shift), ...list.sublist(0, n + shift)];
    } else {
      return [...list.sublist(shift), ...list.sublist(0, shift)];
    }
  }
}
