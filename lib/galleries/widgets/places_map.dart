// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:after_layout/after_layout.dart';

// import '../area_of_interest.dart';
// import '../bottom_sheet/place_info_bottom_sheet..dart';
// import '../services/map_service.dart';

// class PlacesMap extends StatefulWidget {
//   final String imageSrc;
  
//   const PlacesMap({super.key, required this.imageSrc });

//   @override
//   State<PlacesMap> createState() => _PlacesMapState();
// }

// class _PlacesMapState extends State<PlacesMap> with  AfterLayoutMixin<PlacesMap> {
//   final _transformationController = TransformationController();
//   final GlobalKey _imageKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//             onTapUp: _onTapUp,
//             child: InteractiveViewer(
//               scaleEnabled: false,
//               transformationController: _transformationController,
//               child: Image.asset(
//                 widget.imageSrc,
//                 key: _imageKey,
//               ),
//             ),
//           )
//   }
  
//   @override
//   Future<void> afterFirstLayout(BuildContext context) async {
//     final renderedSize = _imageKey.currentContext!.size!;
//     _map = await MapService().getMap(
//         renderedSize, _imageKey, _transformationController, this, (area) {
//       if (area.isLeaf) {
//         _openBottomSheet(context, area);
//         return;
//       }

//       _isInitial = !_map.isZoomed();
//       if (_isInitial) {
//         _showGuide = true;
//       }
//       if (!_isInitial) {
//         _showBackArrow = true;
//       }

//       setState(() {});
//     });
//   }
  
//   Future<void> _onTapUp(TapUpDetails details) async {
//     await _map.tap(details);
//     if (!_isInitial) {
//       _showGuide = false;
//     }
//     if (_isInitial) {
//       _showBackArrow = false;
//     }

//     setState(() {});
//   }

  

//   void _openBottomSheet(BuildContext context, AreaOfInterest area) {
//     if (area.placeId == null) {
//       return;
//     }

//     MapService().getPlace(area.placeId!).then((place) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         barrierColor: Colors.transparent,
//         builder: (BuildContext context) {
//           return PlaceInfoBottomSheet(place: place);
//         },
//       );
//     });
//   }
// }