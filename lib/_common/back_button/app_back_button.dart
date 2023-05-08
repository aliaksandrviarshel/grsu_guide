import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AppBackButton extends StatelessWidget {
  final void Function() onPressed;

  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
    );
  }
}
