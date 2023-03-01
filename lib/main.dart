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
        '/': (context) => const GalleriesPage(),
      },
    );
  }
}
