import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/_common/guide/tour_guide.dart';

import '../navigation/app_drawer_factory.dart';

class UnfinishedPage extends StatelessWidget {
  const UnfinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Get.find<AppDrawerFactory>().drawer(),
      endDrawer: Get.find<AppDrawerFactory>().endDrawer(),
      body: const Stack(
        children: [
          Center(child: Icon(Icons.construction, size: 64)),
          TourGuide(message: 'Мы работаем над этой страницей'),
        ],
      ),
    );
  }
}
