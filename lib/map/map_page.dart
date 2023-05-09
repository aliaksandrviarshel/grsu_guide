import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/_common/connection_checker/connection_checker.dart';
import 'package:grsu_guide/_common/guide/tour_guide.dart';
import 'package:grsu_guide/_common/unfinished_page/unfinished_page.dart';
import 'package:grsu_guide/map/bottom_sheet/place.dart';
import 'package:grsu_guide/map/map/leaf_area_of_interest.dart';

import '../_common/back_button/app_back_button.dart';
import '../_common/dotted_progress_indicator/dotted_progress_indicator.dart';
import '../navigation/app_drawer_factory.dart';

import 'bottom_sheet/place_info_bottom_sheet..dart';
import 'map/area_of_interest.dart';
import 'map/interactive_map.dart';
import 'services/map_service.dart';
import 'services/places_service.dart';

// TODO: get image with shadow
class MapPage extends StatefulWidget {
  final String mapId;

  const MapPage({super.key, required this.mapId});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey _imageKey = GlobalKey();
  final _transformationController = TransformationController();
  InteractiveMap? _map;
  var _isInitial = true;
  var _showGuide = true;
  var _showBackArrow = false;

  @override
  void dispose() {
    _map?.dispose();
    super.dispose();
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
      body: ConnectionChecker(
        child: FutureBuilder(
            future: MapService().getImageSrc(widget.mapId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const DottedProgressIndicator();
              }

              if (snapshot.requireData.isEmpty) {
                return const UnfinishedPage();
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
                          ).then((_) => _zoomToInitialPlace(context));
                        }

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              key: _imageKey,
                              snapshot.requireData,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }

                                return const DottedProgressIndicator();
                              },
                            ),
                            ..._getMarkers()
                          ],
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
      ),
    );
  }

  List<Widget> _getMarkers() {
    final leafAreas = _map?.getLeafAreas() ?? List<LeafAreaOfInterest>.empty();
    return leafAreas.map((area) => Marker(area: area)).toList();
  }

  Future<void> _zoomToInitialPlace(BuildContext context) async {
    final place = ModalRoute.of(context)?.settings.arguments as Place?;
    if (place != null) {
      await _map!.zoomToAndTap(place);
      _isInitial = _map!.isZoomed();
      if (_isInitial) {
        _showGuide = true;
      } else {
        _showBackArrow = true;
      }

      setState(() {});
    }
  }

  Future<void> _initMap(BuildContext context, Size renderedSize) async {
    _map = await Get.find<MapService>().getMap(
      widget.mapId,
      renderedSize,
      _imageKey,
      _transformationController,
      this,
      _onAreaTap,
    );
    _map!.init();
    setState(() {});
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

class Marker extends StatefulWidget {
  final AreaOfInterest area;

  const Marker({
    super.key,
    required this.area,
  });

  @override
  State<Marker> createState() => _MarkerState();
}

class _MarkerState extends State<Marker> {
  double _position = 0.0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _position = _position == 0 ? 8 : 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.area.rect.top - 42,
      left: widget.area.rect.center.dx - 12,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        margin: EdgeInsets.only(top: _position),
        child: Image.asset(
          'assets/images/map_marker_small.png',
          width: 30,
        ),
      ),
    );
  }
}
