import 'package:flutter/material.dart';

import 'package:grsu_guide/_common/guide/guide_wrapper.dart';

class GalleriesPage extends StatefulWidget {
  const GalleriesPage({super.key});

  @override
  State<GalleriesPage> createState() => _GalleriesPageState();
}

class _GalleriesPageState extends State<GalleriesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GuideWrapper(child: Center(child: Text('map'))),
    );
  }
}
