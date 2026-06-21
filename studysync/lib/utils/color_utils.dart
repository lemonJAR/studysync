import 'package:flutter/material.dart';

class ColorUtils {
  // Get category color
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'assignment':
        return Colors.blue;
      case 'quiz':
        return Colors.orange;
      case 'project':
        return Colors.green;
      case 'exam':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get status color
  static Color getStatusColor(String status) {
    if (status.toLowerCase() == 'completed') {
      return Colors.green;
    } else if (status.toLowerCase() == 'pending') {
      return Colors.orange;
    }
    return Colors.grey;
  }

  // Get priority color
  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  // Lighten color
  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lighter = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lighter.toColor();
  }

  // Darken color
  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final darker = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darker.toColor();
  }

  // Get contrasting text color (black or white)
  static Color getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
