import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/_common/unfinished_page/unfinished_page.dart';
import 'package:grsu_guide/map/services/map_firebase_repository.dart';
import 'package:grsu_guide/map/services/map_repository.dart';
import 'package:grsu_guide/map/services/places_firebase_repository.dart';
import 'package:grsu_guide/map/services/places_service.dart';
import 'package:grsu_guide/navigation/nav_wheel/navigation_items_service.dart';
import 'package:grsu_guide/settings/settings_page.dart';
import 'package:grsu_guide/virtual_gallery/services/virtual_gallery_firebase_repository.dart';
import 'package:grsu_guide/virtual_gallery/virtual_gallery_page.dart';

import 'favorites/favorites_page.dart';
import 'map/map_page.dart';
import 'map/services/map_service.dart';
import 'map/services/places_repository.dart';
import 'navigation/app_drawer_factory.dart';
import 'navigation/routes.dart';
import 'settings/app_settings.dart';
import 'splash/splash_screen.dart';
import 'virtual_gallery/services/virtual_gallery_repository.dart';

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
  Get.lazyPut<MapRepository>(() => MapFirebaseRepository());
  Get.lazyPut(() => PlacesService());
  Get.lazyPut<PlacesRepository>(() => PlacesFirebaseRepository());
  Get.lazyPut<VirtualGalleryRepository>(
      () => VirtualGalleryFirebaseRepository());
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
        Routes.virtualGallery: (context) => 
            const MapPage(mapId: 'virtualGallery'),
        Routes.favorites: (context) => const MapPage(mapId: 'favorites'),
        Routes.settings: (context) => const MapPage(mapId: 'settings'),
        Routes.libraries: (context) => const MapPage(mapId: 'libraries'),
        Routes.cafes: (context) => const MapPage(mapId: 'cafes'),
        Routes.dormitories: (context) => const MapPage(mapId: 'dormitories'),
        Routes.architecture: (context) => const MapPage(mapId: 'architecture'),
        Routes.leisure: (context) => const MapPage(mapId: 'leisure'),
        Routes.artStores: (context) => const MapPage(mapId: 'artStores'),
      },
    );
  }
}
