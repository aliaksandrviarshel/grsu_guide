import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'message.dart';

class TourGuideFullHeight extends StatelessWidget {
  final guideAspectRatio = 202 / 684;

  const TourGuideFullHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final guideWidth = constraints.maxHeight * guideAspectRatio;
      final guideHeight = constraints.maxHeight;

      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child:
                Image.asset('assets/images/guide_woman/guide_full_height.png'),
          ),
          Positioned(
            top: guideHeight * .19,
            right: guideWidth - 24,
            child: MessageBox(
              message:
                  AppLocalizations.of(context)!.dontYouHaveAnyFavoritePlaces,
            ),
          )
        ],
      );
    });
  }
}
