import 'package:flutter/material.dart';

import 'galleries/screens/galleries_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const GalleriesPage(mapId: 'eb94f6b4-06ff-4dd3-9ec6-36f5a7baa2b9'),
      },
    );
  }
}
