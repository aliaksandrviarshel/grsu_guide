import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;

  const MessageBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('assets/images/guide_woman/message.png'),
      Positioned.fill(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(message),
          ),
        ),
      ),
    ]);
  }
}
