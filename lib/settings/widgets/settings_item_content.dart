import 'package:flutter/material.dart';

class SettingsItemContent extends StatelessWidget {
  final String title;

  const SettingsItemContent({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
