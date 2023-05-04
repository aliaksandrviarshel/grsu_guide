import 'dart:ui';

import 'package:flutter/material.dart';

import 'nav_wheel.dart';

class AppDrawer extends StatelessWidget {
  final NavWheelAlignment alignment;

  const AppDrawer({super.key, this.alignment = NavWheelAlignment.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * .9,
      height: double.infinity,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
        child: NavWheel(alignment: alignment),
      ),
    );
  }
}
