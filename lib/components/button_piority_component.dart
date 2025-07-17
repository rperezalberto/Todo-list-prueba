import 'package:flutter/material.dart';

class ButtonPiorityComponent extends StatelessWidget {
  final String title;
  final Color colorBorder;
  const ButtonPiorityComponent(
      {super.key, required this.title, required this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorBorder,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          title,
        ),
      ),
    );
  }
}
