import 'package:flutter/material.dart';

enum Routes {
  galleriesMap,
  academicBuildings,
  libraries,
  favorites,
  cafes,
  dormitories,
  architecture,
  leisure,
  artStores,
  virtualGallery,
  settings,
}

class NavigationItem {
  final String name;
  final Widget smallIcon;
  final Widget largeIcon;
  final void Function(BuildContext) onTap;
  final Routes route;
  final String routeName;

  NavigationItem({
    required this.route,
    required this.routeName,
    required this.name,
    required this.smallIcon,
    required this.largeIcon,
    required this.onTap,
  });

  factory NavigationItem.fromRoute(Routes route) {
    return _navItems.firstWhere((element) => element.route == route);
  }

  bool isCurrent(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)!.settings.name;
    return currentRouteName == routeName;
  }

  Future navigate(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }
}

// TODO: make all large icons be the same size
final _navItems = [
  NavigationItem(
    route: Routes.galleriesMap,
    routeName: '/galleries_map',
    name: 'Выставочные залы и галереи',
    smallIcon: Image.asset(
      'assets/icons/navigation/galleries_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/galleries_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.academicBuildings,
    routeName: '/empty',
    name: 'Учебные корпуса и персоналии',
    smallIcon: Image.asset(
      'assets/icons/navigation/academic_buildings_small.png',
      width: 30,
    ),
    largeIcon:
        Image.asset('assets/icons/navigation/academic_buildings_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.libraries,
    routeName: '/empty',
    name: 'Библиотеки и читальные залы',
    smallIcon: Image.asset(
      'assets/icons/navigation/libraries_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/libraries_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.favorites,
    routeName: '/favorites',
    name: 'Избранное',
    smallIcon: Image.asset(
      'assets/icons/navigation/favorites_small.png',
      width: 30,
    ),
    largeIcon:
        Image.asset('assets/icons/navigation/favorites_large.png', width: 120),
    onTap: (BuildContext context) =>
        Navigator.pushNamed(context, '/favorite_list'),
  ),
  NavigationItem(
    route: Routes.cafes,
    routeName: '/empty',
    name: 'Кафе / столовые',
    smallIcon: Image.asset(
      'assets/icons/navigation/cafes_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/cafes_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.dormitories,
    routeName: '/empty',
    name: 'Общежития',
    smallIcon: Image.asset(
      'assets/icons/navigation/dormitories_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/dormitories_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.architecture,
    routeName: '/empty',
    name: 'Архитектура',
    smallIcon: Image.asset(
      'assets/icons/navigation/architecture_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/architecture_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.leisure,
    routeName: '/empty',
    name: 'Досуг',
    smallIcon: Image.asset(
      'assets/icons/navigation/leisure_small.png',
      width: 30,
    ),
    largeIcon: Image.asset('assets/icons/navigation/leisure_large.png'),
    onTap: (BuildContext context) => print('bruh'),
  ),
  NavigationItem(
    route: Routes.artStores,
    routeName: '/empty',
    name: 'Арт-магазины и фотоателье',
    smallIcon: Image.asset(
      'assets/icons/navigation/art_stores_small.png',
      width: 30,
    ),
    largeIcon:
        Image.asset('assets/icons/navigation/art_stores_large.png', width: 120),
    onTap: (BuildContext context) => Navigator.pushNamed(context, '/nav_art'),
  ),
  NavigationItem(
    route: Routes.virtualGallery,
    routeName: '/virtual_gallery',
    name: 'Виртуальная галерея',
    smallIcon: Image.asset(
      'assets/icons/navigation/virtual_gallery_small.png',
      width: 30,
    ),
    largeIcon: Image.asset(
      'assets/icons/navigation/virtual_gallery_large.png',
      height: 110,
    ),
    onTap: (BuildContext context) =>
        Navigator.pushNamed(context, '/virtual_gallery'),
  ),
  NavigationItem(
    route: Routes.settings,
    routeName: '/empty',
    name: 'Настройки',
    smallIcon: Image.asset(
      'assets/icons/navigation/settings_small.png',
      width: 30,
    ),
    largeIcon:
        Image.asset('assets/icons/navigation/settings_large.png', height: 110),
    onTap: (BuildContext context) => Navigator.pushNamed(context, '/settings'),
  ),
];
