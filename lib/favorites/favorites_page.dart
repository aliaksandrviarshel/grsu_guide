import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/_common/back_button/app_back_button.dart';
import 'package:grsu_guide/_common/connection_checker/connection_checker.dart';
import 'package:grsu_guide/galleries/services/places_service.dart';

import '../navigation/app_drawer_factory.dart';

import 'empty_favorites_page_content.dart';
import 'filled_favorites_page_content.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _placesService = Get.find<PlacesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Get.find<AppDrawerFactory>().drawer(),
      endDrawer: Get.find<AppDrawerFactory>().endDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: AppBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ConnectionChecker(
        child: FutureBuilder(
            future: _placesService.getFavoritePlaces(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
      
              return snapshot.requireData.isEmpty
                  ? const EmptyFavoritesPageContent()
                  : FilledFavoritesPageContent(
                      places: snapshot.requireData,
                      onLastPlaceRemoved: () => setState(() {}),
                    );
            }),
      ),
    );
  }
}
