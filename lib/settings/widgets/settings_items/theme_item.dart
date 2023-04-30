import 'package:flutter/material.dart';

import '../settings_item_content.dart';

class ThemeItem extends StatefulWidget {
  const ThemeItem({super.key});

  @override
  State<ThemeItem> createState() => _ThemeItemState();
}

class _ThemeItemState extends State<ThemeItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print('object');
      },
      child: const SettingsItemContent(title: 'Тема'),
    );
  }
}
