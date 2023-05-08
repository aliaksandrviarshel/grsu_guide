import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/_common/unfinished_page/unfinished_page.dart';
import 'package:grsu_guide/map/services/map_repository.dart';
import 'package:grsu_guide/map/services/places_repository.dart';
import 'package:grsu_guide/map/services/places_service.dart';
import 'package:grsu_guide/navigation/nav_wheel/navigation_items_service.dart';
import 'package:grsu_guide/settings/settings_page.dart';
import 'package:grsu_guide/virtual_gallery/services/virtual_gallery_repository.dart';
import 'package:grsu_guide/virtual_gallery/virtual_gallery_page.dart';

import 'favorites/favorites_page.dart';
import 'map/map_page.dart';
import 'map/services/map_service.dart';
import 'navigation/app_drawer_factory.dart';
import 'navigation/routes.dart';
import 'settings/app_settings.dart';
import 'splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final settings = Get.put(AppSettings());
  await settings.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => settings,
      child: const MyApp(),
    ),
  );
  Get.lazyPut(() => MapService());
  Get.lazyPut(() => MapRepository());
  Get.lazyPut(() => PlacesService());
  Get.lazyPut(() => PlacesRepository());
  Get.lazyPut(() => VirtualGalleryRepository());
  Get.lazyPut(() => AppDrawerFactory());
  Get.lazyPut(() => NavigationItemsService());

  Get.find<AppSettings>().init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Provider.of<AppSettings>(context).currentLocale,
      theme: Provider.of<AppSettings>(context).currentTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        Routes.galleriesMap: (context) => const MapPage(mapId: 'galleries'),
        Routes.academicBuildings: (context) =>
            const MapPage(mapId: 'academicBuildings'),
        Routes.virtualGallery: (context) => const VirtualGalleryPage(),
        Routes.favorites: (context) => const FavoritesPage(),
        Routes.settings: (context) => const SettingsPage(),
        Routes.libraries: (context) => const UnfinishedPage(),
        Routes.cafes: (context) => const UnfinishedPage(),
        Routes.dormitories: (context) => const UnfinishedPage(),
        Routes.architecture: (context) => const UnfinishedPage(),
        Routes.leisure: (context) => const UnfinishedPage(),
        Routes.artStores: (context) => const UnfinishedPage(),
      },
    );
  }
}
