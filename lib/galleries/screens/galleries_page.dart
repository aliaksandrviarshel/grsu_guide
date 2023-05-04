import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/_common/guide/tour_guide.dart';
import 'package:grsu_guide/galleries/map/leaf_area_of_interest.dart';

import '../../_common/back_button/back_button.dart';
import '../../navigation/app_drawer_factory.dart';
import '../bottom_sheet/place_info_bottom_sheet..dart';
import '../map/area_of_interest.dart';
import '../map/interactive_map.dart';
import '../services/map_service.dart';
import '../services/places_service.dart';

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
  final GlobalKey _imageKey = GlobalKey();
  final _transformationController = TransformationController();
  InteractiveMap? _map;
  var _isInitial = true;
  var _showGuide = true;
  var _showBackArrow = false;

  Future<void> _initMap(BuildContext context, Size renderedSize) async {
    _map = await Get.find<MapService>().getMap(
      renderedSize,
      _imageKey,
      _transformationController,
      this,
      _onAreaTap,
    );
    _map!.init();
  }

  @override
  void dispose() {
    _map?.dispose();
    super.dispose();
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    await _map!.tap(details);
    if (!_isInitial) {
      _showGuide = false;
    } else {
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
        actions: <Widget>[Container()],
        leading: AnimatedOpacity(
          opacity: _isInitial ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: _showBackArrow
              ? AppBackButton(onPressed: _onBackButtonPressed)
              : null,
        ),
      ),
      drawer: Get.find<AppDrawerFactory>().drawer(),
      endDrawer: Get.find<AppDrawerFactory>().endDrawer(),
      backgroundColor: const Color(0xffcccde1),
      body: FutureBuilder(
          future: MapService().getImageSrc(widget.mapId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTapUp: _onTapUp,
                  child: InteractiveViewer(
                    scaleEnabled: false,
                    panAxis: _map?.isZoomed() ?? true
                        ? PanAxis.free
                        : PanAxis.vertical,
                    transformationController: _transformationController,
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (_map == null) {
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

  void _onAreaTap(AreaOfInterest area) {
    if (area.isLeaf) {
      _openBottomSheet(context, area as LeafAreaOfInterest);
      return;
    }

    _isInitial = !_map!.isZoomed();
    if (_isInitial) {
      _showGuide = true;
    } else {
      _showBackArrow = true;
    }

    setState(() {});
  }

  void _openBottomSheet(BuildContext context, LeafAreaOfInterest area) {
    if (area.placeId == null) {
      return;
    }

    Get.find<PlacesService>().getPlace(area.placeId).then((place) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) => PlaceInfoBottomSheet(place: place),
      );
    });
  }

  Future<void> _onBackButtonPressed() async {
    if (_isInitial) {
      return;
    }

    _isInitial = true;
    _showGuide = true;
    setState(() {});
    await _map!.zoomOut();
    _showBackArrow = false;
    setState(() {});
  }
}
