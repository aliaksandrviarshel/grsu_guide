import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:grsu_guide/settings/app_settings.dart';

import '../../../theme/app_themes.dart';
import '../settings_item_content.dart';

class ThemeItem extends StatefulWidget {
  const ThemeItem({super.key});

  @override
  State<ThemeItem> createState() => _ThemeItemState();
}

class _ThemeItemState extends State<ThemeItem> {
  final _settings = Get.find<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return SettingsItemContent(
      title: Provider.of<AppSettings>(context).currentTheme == AppThemes.light
          ? AppLocalizations.of(context)!.lightTheme
          : AppLocalizations.of(context)!.darkTheme,
      onTap: _settings.toggleTheme,
    );
  }
}
