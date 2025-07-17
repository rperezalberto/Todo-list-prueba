import 'package:flutter/material.dart';

class CustomButtonComponent extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const CustomButtonComponent(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeColor.primary,
                themeColor.primary,
                themeColor.onSecondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          )),
        ),
      ),
    );
  }
}
