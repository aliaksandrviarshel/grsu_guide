import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:grsu_guide/navigation/app_drawer.dart';

import '../_common/guide/tour_guide_full_height.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6DAF0),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // TODO: remove hardcoded routing
            Navigator.of(context).pushReplacementNamed('/galleries_map');
          },
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Избранное',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Места, в которые хочется вернуться')
                  ],
                ),
              ),
              Expanded(child: TourGuideFullHeight()),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/favorites/menu_swipe.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 120.0,
                          right: 32.0,
                          left: 32.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: TextButton(
                            onPressed: () {
                              // TODO: remove hardcoded routing
                              Navigator.of(context)
                                  .pushReplacementNamed('/galleries_map');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all(
                                const Color(0xff383838),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(88),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0)),
                              ),
                            ),
                            child: const Text(
                              'Добавить место',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
