import 'package:flutter/material.dart';

import 'package:grsu_guide/settings/services/settings_service.dart';

import '../settings_item_content.dart';

class ForLeftHandedItem extends StatefulWidget {
  const ForLeftHandedItem({super.key});

  @override
  State<ForLeftHandedItem> createState() => _ForLeftHandedItemState();
}

class _ForLeftHandedItemState extends State<ForLeftHandedItem> {
  final _settingsService = SettingsService();
  late String _title;

  @override
  void initState() {
    super.initState();
    _setTitle(_settingsService.isForLeftHanded.value);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: _title,
      onTap: () async {
        final title = await _settingsService.toggleForLeftHanded();
        _setTitle(title);
      },
    );
  }

  void _setTitle(bool isForLeftHanded) {
    _title = isForLeftHanded ? 'Для леворучек' : 'Для праворучек';
    setState(() {});
  }
}
