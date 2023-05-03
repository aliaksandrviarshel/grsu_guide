// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:grsu_guide/settings/widgets/settings_items/about_developers_item.dart';
import 'package:grsu_guide/settings/widgets/settings_items/language_item.dart';
import 'package:grsu_guide/settings/widgets/settings_items/learning_item.dart';
import 'package:grsu_guide/settings/widgets/settings_items/theme_item.dart';

import '../widgets/settings_items/for_left_handed_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Widget> get items => [
        const ForLeftHandedItem(),
        const AboutDevelopersItem(),
        const LanguageItem(),
        const ThemeItem(),
        const LearningItem(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 24, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/galleries_map');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                    )),
                const Text('Настройки', style: TextStyle(fontSize: 24))
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        Column(children: _getItems())
      ]),
    );
  }

  List<Widget> _getItems() {
    return items
        .map((e) => Container(
            margin: const EdgeInsets.only(bottom: 18, left: 30, right: 30),
            child: e))
        .toList();
  }
}
