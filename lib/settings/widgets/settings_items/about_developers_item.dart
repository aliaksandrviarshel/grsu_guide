import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings_item_content.dart';

class AboutDevelopersItem extends StatefulWidget {
  const AboutDevelopersItem({super.key});

  @override
  State<AboutDevelopersItem> createState() => _AboutDevelopersItemState();
}

class _AboutDevelopersItemState extends State<AboutDevelopersItem> {
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
            ));
          },
        );
      },
    );
  }
}
