import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigation_item.dart';
import '../routes.dart';

class NavigationItemsRepository {
  List<NavigationItem>? _navItems;

  NavigationItem getNavItem(BuildContext context, String routeName) {
    return _lazyGetNavItems(context).firstWhere((element) => element.route == routeName);
  }

  // TODO: make all large icons be the same size
  List<NavigationItem> _lazyGetNavItems(BuildContext context) {
    return _navItems ??= _getNavItems(context);
  }

  List<NavigationItem> _getNavItems(BuildContext context) {
    return [
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
  }
}
