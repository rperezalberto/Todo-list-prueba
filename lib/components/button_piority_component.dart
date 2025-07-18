import 'package:flutter/material.dart';

class ButtonPiorityComponent extends StatelessWidget {
  final String title;
  final Color colorBorder;
  final bool isSelected;
  final VoidCallback? onTap;

  const ButtonPiorityComponent({
    super.key,
    required this.title,
    required this.colorBorder,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? colorBorder : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorBorder,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? themeColor.surface : themeColor.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
