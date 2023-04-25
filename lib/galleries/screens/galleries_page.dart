import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:grsu_guide/_common/guide/tour_guide.dart';
import 'package:grsu_guide/galleries/area_of_interest.dart';

import '../bottom_sheet/place_info_bottom_sheet..dart';
import '../interactive_map.dart';
import '../services/map_service.dart';

// TODO: change bottomsheet animation
// TODO: get image with shadow
class GalleriesPage extends StatefulWidget {
  final String mapId;

  const GalleriesPage({super.key, required this.mapId});

  @override
  State<GalleriesPage> createState() => _GalleriesPageState();
}

class _GalleriesPageState extends State<GalleriesPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const bgColor = Color(0xffcccde1);
  final GlobalKey _imageKey = GlobalKey();
  final _transformationController = TransformationController();
  late final InteractiveMap _map;

  var _isInitial = true;
  var _showGuide = true;
  var _showBackArrow = false;

  Future<void> _initMap(BuildContext context, Size renderedSize) async {
    _map = await MapService().getMap(
        renderedSize, _imageKey, _transformationController, this, (area) {
      if (area.isLeaf) {
        _openBottomSheet(context, area);
        return;
      }

      _isInitial = !_map.isZoomed();
      if (_isInitial) {
        _showGuide = true;
      }
      if (!_isInitial) {
        _showBackArrow = true;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _map.dispose();
    super.dispose();
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    await _map.tap(details);
    if (!_isInitial) {
      _showGuide = false;
    }
    if (_isInitial) {
      _showBackArrow = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: AnimatedOpacity(
          opacity: _isInitial ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: _showBackArrow
              ? IconButton(
                  onPressed: () async {
                    if (_isInitial) {
                      return;
                    }

                    _isInitial = true;
                    _showGuide = true;
                    setState(() {});
                    await _map.zoomOut();
                    _showBackArrow = false;
                    setState(() {});
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
                )
              : null,
        ),
      ),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: MapService().getImageSrc(widget.mapId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('bruh'),
              );
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTapUp: _onTapUp,
                  child: InteractiveViewer(
                    scaleEnabled: false,
                    transformationController: _transformationController,
                    child: LayoutBuilder(builder: (context, constraints) {
                      try {
                        _map == null;
                      } catch (e) {
                        _initMap(
                          context,
                          Size(constraints.maxWidth, constraints.maxHeight),
                        );
                      }

                      return Image.asset(
                        snapshot.requireData,
                        key: _imageKey,
                      );
                    }),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _isInitial ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: _showGuide ? const TourGuide() : null,
                ),
              ],
            );
          }),
    );
  }

  void _openBottomSheet(BuildContext context, AreaOfInterest area) {
    if (area.placeId == null) {
      return;
    }

    MapService().getPlace(area.placeId!).then((place) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return PlaceInfoBottomSheet(place: place);
        },
      );
    });
  }
}
