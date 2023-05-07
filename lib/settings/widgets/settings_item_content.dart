import 'package:flutter/material.dart';

class SettingsItemContent extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const SettingsItemContent({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
