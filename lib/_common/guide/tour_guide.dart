import 'package:flutter/cupertino.dart';

import 'package:grsu_guide/_common/guide/message.dart';

class TourGuide extends StatelessWidget {
  final _guideImageRatio = 237 / 467;

  const TourGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guideImageHeight = MediaQuery.of(context).size.height / 2;
    final guideImageWidth = guideImageHeight * _guideImageRatio;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
              height: guideImageHeight,
              child: Image.asset('assets/images/guide_woman/guide.png')),
        ),
        Positioned(
          bottom: guideImageHeight / 3,
          right: guideImageWidth / 6 * 5,
          child: const MessageBox(message: 'Куда отправимся сегодня?'),
        )
      ],
    );
  }
}
