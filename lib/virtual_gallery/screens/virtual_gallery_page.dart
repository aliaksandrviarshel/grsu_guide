import 'package:flutter/material.dart';

import 'package:grsu_guide/virtual_gallery/services/virtual_gallery_service.dart';

import '../services/picture_dto.dart';

// TODO: move assets to database
class VirtualGalleryPage extends StatefulWidget {
  const VirtualGalleryPage({super.key});

  @override
  State<VirtualGalleryPage> createState() => _VirtualGalleryPageState();
}

class _VirtualGalleryPageState extends State<VirtualGalleryPage> {
  late final List<PictureDto> imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC8C8D0),
      body: FutureBuilder(
          future: VirtualGalleryService().getPictures(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            imageData = snapshot.requireData;
            return NestedScrollView(
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: _getImages()),
              )),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const SliverAppBar(
                    backgroundColor: Color(0xffC8C8D0),
                    expandedHeight: 120,
                    pinned: true,
                    centerTitle: true,
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
          }),
    );
  }

  List<Widget> _getImages() {
    return imageData
        .map((e) => Picture(
              picture: e,
            ))
        .toList();
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
              child: Image.asset(picture.asset),
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
                      child: Image.asset(
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
