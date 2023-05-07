import 'package:flutter/material.dart';

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
              Text('Избранное',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
              Text(
                'Места, в которые хочется вернуться',
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
