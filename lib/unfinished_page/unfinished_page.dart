import 'package:flutter/material.dart';

import 'package:grsu_guide/_common/guide/tour_guide.dart';

import '../navigation/app_drawer.dart';

class UnfinishedPage extends StatelessWidget {
  const UnfinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffCCCDE1),
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Center(child: Icon(Icons.construction, size: 64)),
          TourGuide(message: 'Мы работаем над этой страницей'),
        ],
      ),
    );
  }
}
