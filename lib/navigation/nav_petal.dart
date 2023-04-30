import 'package:flutter/material.dart';

import 'package:grsu_guide/navigation/petal_painter.dart';

class NavPetal extends StatefulWidget {
  final String title;
  final Widget icon;
  final bool isTransparent;
  final Widget largeIcon;

  const NavPetal({
    Key? key,
    required this.title,
    required this.icon,
    required this.largeIcon,
    required this.isTransparent,
  }) : super(key: key);

  @override
  State<NavPetal> createState() => _NavPetalState();
}

class _NavPetalState extends State<NavPetal> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double petalHeight = MediaQuery.of(context).size.width * .7;
    double screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = 150 / 250;

    return SizedBox(
      width: petalHeight * aspectRatio,
      height: petalHeight + 20,
      child: CustomPaint(
        painter: MyPainter(
          color: widget.isTransparent
              ? const Color(0x00cdbcff)
              : const Color(0xffCDBCFF),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: OverflowBox(
            maxHeight: screenWidth * .9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: widget.isTransparent ? 0 : 50,
                  top: widget.isTransparent ? 170 : null,
                  child: SizedBox(
                    height: widget.isTransparent
                        ? screenWidth * .6
                        : petalHeight * .7,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        textAlign: widget.isTransparent ? TextAlign.end : null,
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
                            quarterTurns: 3,
                            child: SizedBox(
                              width: 170,
                              height: 170,
                              child: widget.largeIcon,
                            ),
                          )
                        : RotatedBox(quarterTurns: 3, child: widget.icon),
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
