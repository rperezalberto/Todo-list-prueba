import 'package:flutter/material.dart';

enum PriorityEnum { low, medium, high }

extension PriorityExtension on PriorityEnum {
  String get label {
    switch (this) {
      case PriorityEnum.low:
        return 'Baja';
      case PriorityEnum.medium:
        return 'Media';
      case PriorityEnum.high:
        return 'Alta';
    }
  }

  Color get borderColor {
    switch (this) {
      case PriorityEnum.low:
        return Color(0xFFFACBBA);
      case PriorityEnum.medium:
        return Color(0xFFD7F0FF);
      case PriorityEnum.high:
        return Color(0xFFFAD9FF);
    }
  }
}
