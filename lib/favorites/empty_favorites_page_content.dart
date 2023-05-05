import 'package:flutter/material.dart';

import 'favorites_page_background.dart';

class EmptyFavoritesPageContent extends StatelessWidget {
  const EmptyFavoritesPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const FavoritesPageBackground(),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 320,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xffBFC1E9).withOpacity(0),
                    const Color(0xffBFC1E9),
                    const Color(0xffBFC1E9),
                    const Color(0xffBFC1E9),
                  ]),
              image: const DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(
                  'assets/images/favorites/menu_swipe.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 120.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const _AddPlaceButton(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPlaceButton extends StatelessWidget {
  const _AddPlaceButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: remove hardcoded routing
        Navigator.of(context).pushReplacementNamed('/galleries_map');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all(
          const Color(0xff383838),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(88),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
      child: const Text(
        'Добавить место',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
