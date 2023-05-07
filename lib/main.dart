import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:grsu_guide/galleries/services/places_service.dart';
import 'package:grsu_guide/settings/screens/settings_page.dart';
import 'package:grsu_guide/unfinished_page/unfinished_page.dart';
import 'package:grsu_guide/virtual_gallery/screens/virtual_gallery_page.dart';
import 'package:grsu_guide/virtual_gallery/services/virtual_gallery_service.dart';

import 'favorites/favorites_page.dart';
import 'galleries/screens/galleries_page.dart';
import 'galleries/services/map_service.dart';
import 'navigation/app_drawer_factory.dart';
import 'settings/app_settings.dart';
import 'splash/splash_screen.dart';

late Database database;

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
  // final databasePath = await getDatabasesPath();
  // await databaseFactory.deleteDatabase('$databasePath/grsu_guide_database.db');
  database = await openDatabase(
    join(await getDatabasesPath(), 'grsu_guide_database.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        '''
          CREATE TABLE places(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageSrc TEXT NOT NULL,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            isFavorite INTEGER NOT NULL)
        ''',
      );

      final placesJson = await rootBundle.loadString('assets/maps/places.json');
      final places = json.decode(placesJson) as List<dynamic>;
      final batch = db.batch();
      for (var element in places) {
        batch.insert('places', element);
      }
      batch.commit();
    },
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
        '/galleries_map': (context) =>
            const GalleriesPage(mapId: 'eb94f6b4-06ff-4dd3-9ec6-36f5a7baa2b9'),
        '/virtual_gallery': (context) => const VirtualGalleryPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
        '/empty': (context) => const UnfinishedPage(),
      },
    );
  }
}
