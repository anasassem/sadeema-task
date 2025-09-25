import 'package:flutter/material.dart';

class ColorUtils {
  /// Convert hex string to Color
  /// Supports formats: #RRGGBB, #AARRGGBB, RRGGBB, AARRGGBB
  static Color fromHex(String hexColor) {
    try {
      // Remove # if present
      hexColor = hexColor.replaceAll('#', '');

      // Add alpha if not provided (make it fully opaque)
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }

      // Parse hex string to integer
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      // Return a default color if parsing fails
      return Colors.grey;
    }
  }

  /// Convert hex string to Color with custom opacity
  static Color fromHexWithOpacity(String hexColor, double opacity) {
    final color = fromHex(hexColor);
    return color.withOpacity(opacity);
  }

  /// Convert Color to hex string
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  /// Get complementary color
  static Color getComplementaryColor(Color color) {
    return Color.fromRGBO(
      255 - color.red,
      255 - color.green,
      255 - color.blue,
      color.opacity,
    );
  }

  /// Get lighter shade of color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Get darker shade of color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Check if color is light or dark
  static bool isLightColor(Color color) {
    final brightness = color.computeLuminance();
    return brightness > 0.5;
  }

  /// Get appropriate text color for background
  static Color getTextColorForBackground(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black87 : Colors.white;
  }
}

// Extension for easier use
extension HexColor on String {
  Color toColor() => ColorUtils.fromHex(this);
  Color toColorWithOpacity(double opacity) => ColorUtils.fromHexWithOpacity(this, opacity);
}

extension ColorExtension on Color {
  String toHex() => ColorUtils.toHex(this);
  Color lighten([double amount = 0.1]) => ColorUtils.lighten(this, amount);
  Color darken([double amount = 0.1]) => ColorUtils.darken(this, amount);
  bool get isLight => ColorUtils.isLightColor(this);
  Color get textColor => ColorUtils.getTextColorForBackground(this);
}