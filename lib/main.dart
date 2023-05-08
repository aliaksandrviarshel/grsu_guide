import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/galleries/services/places_service.dart';
import 'package:grsu_guide/settings/screens/settings_page.dart';
import 'package:grsu_guide/unfinished_page/unfinished_page.dart';
import 'package:grsu_guide/virtual_gallery/screens/virtual_gallery_page.dart';
import 'package:grsu_guide/virtual_gallery/services/virtual_gallery_service.dart';

import 'favorites/favorites_page.dart';
import 'galleries/screens/map_page.dart';
import 'galleries/services/map_service.dart';
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
  Get.put(MapService());
  Get.put(PlacesService());
  Get.put(VirtualGalleryService());
  Get.put(AppDrawerFactory());

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
