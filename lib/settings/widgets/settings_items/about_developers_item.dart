import 'package:flutter/material.dart';

import '../settings_item_content.dart';

class AboutDevelopersItem extends StatefulWidget {
  const AboutDevelopersItem({super.key});

  @override
  State<AboutDevelopersItem> createState() => _AboutDevelopersItemState();
}

class _AboutDevelopersItemState extends State<AboutDevelopersItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(content: Text('Шота пра разработчикав'));
          },
        );
      },
      child: const SettingsItemContent(title: 'О разработчиках'),
    );
  }
}
