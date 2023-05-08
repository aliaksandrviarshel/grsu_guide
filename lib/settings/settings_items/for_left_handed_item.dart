import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/settings/app_settings.dart';

import 'settings_item_content.dart';

class ForLeftHandedItem extends StatelessWidget {
  const ForLeftHandedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: Provider.of<AppSettings>(context).isForLeftHanded
          ? AppLocalizations.of(context)!.forLefties
          : AppLocalizations.of(context)!.forRighties,
      onTap: Get.find<AppSettings>().toggleForLeftHanded,
    );
  }
}
