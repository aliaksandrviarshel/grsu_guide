import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../app_settings.dart';

import 'settings_item_content.dart';

class LanguageItem extends StatefulWidget {
  const LanguageItem({super.key});

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  final _settings = Get.find<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: AppLocalizations.of(context)!.currentLanguage,
      onTap: _settings.toggleLanguage,
    );
  }
}
