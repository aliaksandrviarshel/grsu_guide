import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      body: Stack(
        children: [
          const Center(child: Icon(Icons.construction, size: 64)),
          TourGuide(
            message: AppLocalizations.of(context)!.weAreWorkingOnThisPage,
          ),
        ],
      ),
    );
  }
}
