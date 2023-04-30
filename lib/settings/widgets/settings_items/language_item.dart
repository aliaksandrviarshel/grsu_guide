import 'package:flutter/material.dart';

import '../settings_item_content.dart';

class LanguageItem extends StatefulWidget {
  const LanguageItem({super.key});

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print('object');
      },
      child: const SettingsItemContent(title: 'Язык'),
    );
  }
}
