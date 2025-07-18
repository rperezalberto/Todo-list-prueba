import 'package:flutter/material.dart';

class TextTitleComponent extends StatelessWidget {
  final String title;
  const TextTitleComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        color: themeColor.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
