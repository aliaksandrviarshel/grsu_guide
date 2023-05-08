import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternetConnectionView extends StatelessWidget {
  const NoInternetConnectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.signal_wifi_off, size: 64),
        Text(
          AppLocalizations.of(context)!
              .toAccessThisPageYouNeedAnInternetConnection,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
