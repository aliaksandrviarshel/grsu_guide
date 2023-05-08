import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/nav_wheel/nav_wheel.dart';
import 'package:grsu_guide/navigation/petal/petal_painter.dart';

import 'petal_sizer.dart';

class NavPetal extends StatefulWidget {
  final String title;
  final Widget icon;
  final bool isTransparent;
  final Widget largeIcon;
  final NavWheelAlignment alignment;

  const NavPetal({
    Key? key,
    required this.title,
    required this.icon,
    required this.largeIcon,
    required this.isTransparent,
    this.alignment = NavWheelAlignment.left,
  }) : super(key: key);

  @override
  State<NavPetal> createState() => _NavPetalState();
}

class _NavPetalState extends State<NavPetal> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final petalSize = PetalSizer(context: context).size;
    final screenSize = MediaQuery.of(context).size;
    final quarterTurns = widget.alignment == NavWheelAlignment.left ? 3 : 1;

    return SizedBox(
      width: petalSize.width,
      height: petalSize.height + 20,
      child: CustomPaint(
        painter: MyPainter(
          color: widget.isTransparent
              ? const Color(0x00cdbcff)
              : const Color(0xffCDBCFF),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: OverflowBox(
            maxHeight: screenSize.width * .9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: widget.isTransparent ? 0 : screenSize.height * .05,
                  top: widget.isTransparent ? 170 : null,
                  child: SizedBox(
                    height: widget.isTransparent
                        ? screenSize.width * .6
                        : petalSize.height * .7,
                    child: RotatedBox(
                      quarterTurns: quarterTurns,
                      child: Text(
                        textAlign: widget.isTransparent
                            ? widget.alignment == NavWheelAlignment.left
                                ? TextAlign.end
                                : TextAlign.start
                            : null,
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: widget.isTransparent ? 0 : null,
                  child: AnimatedSwitcher(
                    reverseDuration: Duration.zero,
                    duration: const Duration(milliseconds: 300),
                    child: widget.isTransparent
                        ? RotatedBox(
                            key: const ValueKey(1),
                            quarterTurns: quarterTurns,
                            child: SizedBox(
                              width: 170,
                              height: 170,
                              child: widget.largeIcon,
                            ),
                          )
                        : RotatedBox(
                            quarterTurns: quarterTurns, child: widget.icon),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
