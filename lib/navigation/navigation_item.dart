import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  factory NavigationItem.fromRoute(Routes route, BuildContext context) {
    return getNavItems(context).firstWhere((element) => element.route == route);
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
getNavItems(BuildContext context) => [
      NavigationItem(
        route: Routes.galleriesMap,
        routeName: '/galleries_map',
        name: AppLocalizations.of(context)!.exhibitionHallsAndGalleries,
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
        name: AppLocalizations.of(context)!.academicBuildingsAndPersonalities,
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
        name: AppLocalizations.of(context)!.librariesAndReadingRooms,
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
        name: AppLocalizations.of(context)!.favorites,
        smallIcon: Image.asset(
          'assets/icons/navigation/favorites_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/favorites_large.png',
            width: 120),
        onTap: (BuildContext context) =>
            Navigator.pushNamed(context, '/favorite_list'),
      ),
      NavigationItem(
        route: Routes.cafes,
        routeName: '/empty',
        name: AppLocalizations.of(context)!.cafeDiningRooms,
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
        name: AppLocalizations.of(context)!.dormitories,
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
        name: AppLocalizations.of(context)!.architecture,
        smallIcon: Image.asset(
          'assets/icons/navigation/architecture_small.png',
          width: 30,
        ),
        largeIcon:
            Image.asset('assets/icons/navigation/architecture_large.png'),
        onTap: (BuildContext context) => print('bruh'),
      ),
      NavigationItem(
        route: Routes.leisure,
        routeName: '/empty',
        name: AppLocalizations.of(context)!.leisure,
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
        name: AppLocalizations.of(context)!.artShopsAndPhotoStudios,
        smallIcon: Image.asset(
          'assets/icons/navigation/art_stores_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/art_stores_large.png',
            width: 120),
        onTap: (BuildContext context) =>
            Navigator.pushNamed(context, '/nav_art'),
      ),
      NavigationItem(
        route: Routes.virtualGallery,
        routeName: '/virtual_gallery',
        name: AppLocalizations.of(context)!.virtualGallery,
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
        routeName: '/settings',
        name: AppLocalizations.of(context)!.settings,
        smallIcon: Image.asset(
          'assets/icons/navigation/settings_small.png',
          width: 30,
        ),
        largeIcon: Image.asset('assets/icons/navigation/settings_large.png',
            height: 110),
        onTap: (BuildContext context) =>
            Navigator.pushNamed(context, '/settings'),
      ),
    ];
