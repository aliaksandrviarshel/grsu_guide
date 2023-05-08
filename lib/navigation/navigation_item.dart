import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'routes.dart';

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
    return getNavItems(context).firstWhere((element) => element.route == route);
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

// TODO: make all large icons be the same size
getNavItems(BuildContext context) => [
      NavigationItem(
        route: Routes.galleriesMap,
        routeName: Routes.galleriesMap,
        name: AppLocalizations.of(context)!.exhibitionHallsAndGalleries,
        smallIcon: Image.asset(
          'assets/icons/navigation/galleries_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/galleries_large.png'),
      ),
      NavigationItem(
        route: Routes.academicBuildings,
        routeName: Routes.academicBuildings,
        name: AppLocalizations.of(context)!.academicBuildingsAndPersonalities,
        smallIcon: Image.asset(
          'assets/icons/navigation/academic_buildings_small.png',
          width: 30,
        ),
        largeIcon:
            Image.asset('assets/icons/navigation/academic_buildings_large.png'),
      ),
      NavigationItem(
        route: Routes.libraries,
        routeName: Routes.libraries,
        name: AppLocalizations.of(context)!.librariesAndReadingRooms,
        smallIcon: Image.asset(
          'assets/icons/navigation/libraries_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/libraries_large.png'),
      ),
      NavigationItem(
        route: Routes.favorites,
        routeName: Routes.favorites,
        name: AppLocalizations.of(context)!.favorites,
        smallIcon: Image.asset(
          'assets/icons/navigation/favorites_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/favorites_large.png',
            width: 120),
      ),
      NavigationItem(
        route: Routes.cafes,
        routeName: Routes.cafes,
        name: AppLocalizations.of(context)!.cafeDiningRooms,
        smallIcon: Image.asset(
          'assets/icons/navigation/cafes_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/cafes_large.png'),
      ),
      NavigationItem(
        route: Routes.dormitories,
        routeName: Routes.dormitories,
        name: AppLocalizations.of(context)!.dormitories,
        smallIcon: Image.asset(
          'assets/icons/navigation/dormitories_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/dormitories_large.png'),
      ),
      NavigationItem(
        route: Routes.architecture,
        routeName: Routes.architecture,
        name: AppLocalizations.of(context)!.architecture,
        smallIcon: Image.asset(
          'assets/icons/navigation/architecture_small.png',
          width: 30,
        ),
        largeIcon:
            Image.asset('assets/icons/navigation/architecture_large.png'),
      ),
      NavigationItem(
        route: Routes.leisure,
        routeName: Routes.leisure,
        name: AppLocalizations.of(context)!.leisure,
        smallIcon: Image.asset(
          'assets/icons/navigation/leisure_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/leisure_large.png'),
      ),
      NavigationItem(
        route: Routes.artStores,
        routeName: Routes.architecture,
        name: AppLocalizations.of(context)!.artShopsAndPhotoStudios,
        smallIcon: Image.asset(
          'assets/icons/navigation/art_stores_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/art_stores_large.png',
            width: 120),
      ),
      NavigationItem(
        route: Routes.virtualGallery,
        routeName: Routes.virtualGallery,
        name: AppLocalizations.of(context)!.virtualGallery,
        smallIcon: Image.asset(
          'assets/icons/navigation/virtual_gallery_small.png',
          width: 30,
        ),
        largeIcon: Image.asset(
          'assets/icons/navigation/virtual_gallery_large.png',
          height: 110,
        ),
      ),
      NavigationItem(
        route: Routes.settings,
        routeName: Routes.settings,
        name: AppLocalizations.of(context)!.settings,
        smallIcon: Image.asset(
          'assets/icons/navigation/settings_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/settings_large.png',
            height: 110),
      ),
    ];
