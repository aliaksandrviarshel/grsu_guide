import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/navigation/nav_wheel/navigation_items_repository.dart';

import '../routes.dart';

class NavigationItem {
  final String name;
  final Widget smallIcon;
  final Widget largeIcon;
  final String route;
  final String routeName;
  late final bool isRoot;

  NavigationItem({
    required this.route,
    required this.routeName,
    required this.name,
    required this.smallIcon,
    required this.largeIcon,
  }) {
    isRoot = [
      Routes.academicBuildings,
      Routes.architecture,
      Routes.artStores,
      Routes.cafes,
      Routes.dormitories,
      Routes.galleriesMap,
      Routes.leisure,
      Routes.libraries
    ].contains(route);
  }

  factory NavigationItem.fromRoute(String route, BuildContext context) {
    return Get.find<NavigationItemsRepository>().getNavItem(context, route);
  }

  bool isCurrent(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)!.settings.name;
    return currentRouteName == routeName;
  }

  Future navigate(BuildContext context) {
    if (isRoot) {
      return Navigator.of(context).pushReplacementNamed(routeName);
    }

    return Navigator.of(context).pushNamed(routeName);
  }
}
