// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:grsu_guide/settings/services/settings_service.dart';
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

// class SettingsItem {
//   final String title;
//   final void Function() onTap;

//   SettingsItem({
//     required this.title,
//     required this.onTap,
//   });
// }

class _SettingsPageState extends State<SettingsPage> {
  final _settingsService = SettingsService();

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
                Positioned(
                  left: -12,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 32,
                      )),
                ),
                const Text(
                  'Настройки',
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: _getItems(),
          ),
        )
      ]),
    );
  }

  List<Widget> _getItems() {
    return items.map((e) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // InkWell(
          //   onTap: e.onTap,
          //   child: Container(
          //     height: 60,
          //     alignment: Alignment.centerLeft,
          //     decoration: const BoxDecoration(
          //         color: Color(0xffD9D9D9),
          //         borderRadius: BorderRadius.all(Radius.circular(24))),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 14.0),
          //       child: Text(
          //         e.title.toUpperCase(),
          //         style: const TextStyle(fontSize: 24),
          //       ),
          //     ),
          //   ),
          // ),
          e,
          const SizedBox(height: 18)
        ],
      );
    }).toList();
  }
}
