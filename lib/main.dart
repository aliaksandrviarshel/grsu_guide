import 'package:flutter/material.dart';

import 'package:grsu_guide/virtual_gallery/screens/virtual_gallery_page.dart';

import 'galleries/screens/galleries_page.dart';
import 'splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        drawerTheme: const DrawerThemeData(
          scrimColor: Color.fromRGBO(202, 208, 232, 0.32),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/galleries_map': (context) =>
            const GalleriesPage(mapId: 'eb94f6b4-06ff-4dd3-9ec6-36f5a7baa2b9'),
        '/virtual_gallery': (context) => const VirtualGalleryPage(),
      },
    );
  }
}
