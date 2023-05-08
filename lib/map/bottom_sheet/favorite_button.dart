// TODO: fix button blinking on click
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final GlobalKey imageKey;
  final void Function() onTap;

  const FavoriteButton({
    super.key,
    required this.imageKey,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 2000),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: widget.isFavorite
            ? Image.asset(
                key: widget.imageKey,
                width: 48,
                height: 48,
                'assets/icons/favorites/favorite_active.png')
            : Image.asset(
                key: widget.imageKey,
                width: 48,
                height: 48,
                'assets/icons/favorites/favorite_inactive.png',
              ),
      ),
    );
  }
}
