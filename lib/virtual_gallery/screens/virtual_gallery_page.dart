import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:grsu_guide/_common/dotted_progress_indicator/dotted_progress_indicator.dart';

import '../../_common/back_button/app_back_button.dart';
import '../../_common/connection_checker/connection_checker.dart';
import '../services/picture_dto.dart';
import '../services/virtual_gallery_service.dart';

class VirtualGalleryPage extends StatefulWidget {
  const VirtualGalleryPage({super.key});

  @override
  State<VirtualGalleryPage> createState() => _VirtualGalleryPageState();
}

class _VirtualGalleryPageState extends State<VirtualGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectionChecker(
        child: FutureBuilder(
            future: Get.find<VirtualGalleryService>().getPictures(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const DottedProgressIndicator();
              }

              return VirtualGalleryListView(pictures: snapshot.requireData);
            }),
      ),
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
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 120,
            pinned: true,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading:
                AppBackButton(onPressed: () => Navigator.of(context).pop()),
            title: Text(
              AppLocalizations.of(context)!.virtualGallery,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            flexibleSpace: const FlexibleSpaceBar(
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
                    '${AppLocalizations.of(context)!.author}: ${picture.author}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.painting}: "${picture.title}"',
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            AppLocalizations.of(context)!.virtualGalleryDescription,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}
