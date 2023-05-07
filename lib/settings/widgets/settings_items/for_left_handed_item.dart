import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/settings/app_settings.dart';

import '../settings_item_content.dart';

class ForLeftHandedItem extends StatefulWidget {
  const ForLeftHandedItem({super.key});

  @override
  State<ForLeftHandedItem> createState() => _ForLeftHandedItemState();
}

class _ForLeftHandedItemState extends State<ForLeftHandedItem> {
  final _settingsService = Get.find<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: Provider.of<AppSettings>(context).isForLeftHanded
          ? AppLocalizations.of(context)!.forLefties
          : AppLocalizations.of(context)!.forRighties,
      onTap: _settingsService.toggleForLeftHanded,
    );
  }
}
