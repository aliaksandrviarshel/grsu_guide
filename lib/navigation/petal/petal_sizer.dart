import 'package:flutter/widgets.dart';

class PetalSizer {
  final _aspectRatio = 150 / 250;
  final BuildContext _context;

  const PetalSizer({required BuildContext context}) : _context = context;

  Size get size {
    final height = MediaQuery.of(_context).size.width * .7;
    final width = height * _aspectRatio;
    return Size(width, height);
  }
}
