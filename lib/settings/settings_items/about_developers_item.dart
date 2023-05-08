import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_item_content.dart';

class AboutDevelopersItem extends StatelessWidget {
  const AboutDevelopersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: AppLocalizations.of(context)!.aboutDevelopers,
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                AppLocalizations.of(context)!.somethingAboutDevelopers,
              ),
            );
          },
        );
      },
    );
  }
}
