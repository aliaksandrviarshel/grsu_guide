import 'package:flutter/material.dart';

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
          ? 'Для леворучек'
          : 'Для праворучек',
      onTap: _settingsService.toggleForLeftHanded,
    );
  }
}
