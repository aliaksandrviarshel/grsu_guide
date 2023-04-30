import 'package:flutter/material.dart';

import '../settings_item_content.dart';

class LearningItem extends StatefulWidget {
  const LearningItem({super.key});

  @override
  State<LearningItem> createState() => _LearningItemState();
}

class _LearningItemState extends State<LearningItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print('object');
      },
      child: const SettingsItemContent(title: 'Обучение'),
    );
  }
}
