import 'dart:async';

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../../navigation/app_drawer.dart';
import '../services/picture_dto.dart';
import '../services/virtual_gallery_service.dart';

class VirtualGalleryPage extends StatefulWidget {
  const VirtualGalleryPage({super.key});

  @override
  State<VirtualGalleryPage> createState() => _VirtualGalleryPageState();
}

class _VirtualGalleryPageState extends State<VirtualGalleryPage> {
  final _connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xffC8C8D0),
      body: FutureBuilder(
          future: _connectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.requireData == ConnectivityResult.none) {
              StreamSubscription? listener;
              listener = _connectivity.onConnectivityChanged.listen((event) {
                if (event != ConnectivityResult.none) {
                  listener?.cancel();
                  setState(() {});
                }
              });

              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.signal_wifi_off, size: 64),
                  Text(
                    'Для доступа к виртуальной галерее нужно подключение к интернету',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              );
            }

            return FutureBuilder(
                future: Get.find<VirtualGalleryService>().getPictures(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return VirtualGalleryListView(pictures: snapshot.requireData);
                });
          }),
    );
  }
}

class VirtualGalleryListView extends StatelessWidget {
  final List<PictureDto> _pictures;

  const VirtualGalleryListView({super.key, required List<PictureDto> pictures})
      : _pictures = pictures;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
            children: _pictures.map((e) => Picture(picture: e)).toList()),
      )),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            backgroundColor: Color(0xffC8C8D0),
            expandedHeight: 120,
            pinned: true,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Виртуальная галерея',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MyFlexibleAppBar(),
              ),
            ),
          ),
        ];
      },
    );
  }
}

class Picture extends StatelessWidget {
  final PictureDto picture;

  const Picture({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Image.network(picture.asset),
            );
          },
        );
      },
      child: Column(children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: SizedBox(
                      height: 190,
                      child: Image.network(
                        picture.asset,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xff151515).withOpacity(.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Автор: ${picture.author}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Картина: "${picture.title}"',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    picture.details,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ]),
    );
  }
}

class MyFlexibleAppBar extends StatelessWidget {
  final double appBarHeight = 66.0;

  const MyFlexibleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: statusBarHeight + appBarHeight,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Витуальная галерея - описание Не следует, однако забывать, что реализация намеченных плановых заданий позволяет оценить значение модели развития. Товарищи!',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }
}
