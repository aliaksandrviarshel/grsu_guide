import 'package:flutter/material.dart';

class GalleriesPage extends StatefulWidget {
  const GalleriesPage({super.key});

  @override
  State<GalleriesPage> createState() => _GalleriesPageState();
}

class _GalleriesPageState extends State<GalleriesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('galleries')));
  }
}
