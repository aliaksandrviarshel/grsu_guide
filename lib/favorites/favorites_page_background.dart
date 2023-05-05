import 'package:flutter/widgets.dart';

import '../_common/guide/tour_guide_full_height.dart';

class FavoritesPageBackground extends StatelessWidget {
  final bool isGuideVisible;

  const FavoritesPageBackground({super.key, this.isGuideVisible = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Избранное',
                style: TextStyle(fontSize: 24),
              ),
              Text('Места, в которые хочется вернуться')
            ],
          ),
        ),
        if (isGuideVisible) const Expanded(child: TourGuideFullHeight()),
      ],
    );
  }
}
