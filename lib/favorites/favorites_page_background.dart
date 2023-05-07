import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../_common/guide/tour_guide_full_height.dart';

class FavoritesPageBackground extends StatelessWidget {
  final bool isGuideVisible;

  const FavoritesPageBackground({super.key, this.isGuideVisible = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  AppLocalizations.of(context)!.favorites,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
              Text(
                  AppLocalizations.of(context)!.placesYouWantToReturnTo,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            ],
          ),
        ),
        if (isGuideVisible) const Expanded(child: TourGuideFullHeight()),
      ],
    );
  }
}
