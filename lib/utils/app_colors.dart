import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors - Modern Deep Blue/Purple Gradient Inspired
  static const Color primary = Color(0xFF6366F1); // Vibrant Indigo
  static const Color primaryDark = Color(0xFF4F46E5); // Deep Indigo
  static const Color primaryLight = Color(0xFF818CF8); // Light Indigo
  static const Color accent = Color(0xFFEC4899); // Rose Pink accent
  static const Color accentLight = Color(0xFFF472B6); // Light Pink

  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald Green
  static const Color secondaryLight = Color(0xFF34D399); // Light Emerald

  // Background Colors - Modern minimalist
  static const Color background = Color(0xFFF8FAFC); // Soft Gray-Blue
  static const Color backgroundDark = Color(0xFFF1F5F9); // Slightly darker
  static const Color surface = Colors.white;
  static const Color surfaceElevated = Color(
    0xFFFFFFFF,
  ); // Pure white for cards

  // Error & Status Colors
  static const Color error = Color(0xFFEF4444); // Modern Red
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color info = Color(0xFF3B82F6); // Blue

  // Text Colors - High contrast for readability
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400
  static const Color textHint = Color(0xFFCBD5E1); // Slate 300
  static const Color textOnPrimary = Colors.white;

  // UI Elements
  static const Color divider = Color(0xFFE2E8F0); // Slate 200
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color cardShadow = Color(0x0F000000); // Subtle shadow
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)], // Indigo to Purple
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xFFF59E0B)], // Pink to Amber
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Category Colors - Vibrant but professional
  static const Color categoryBusiness = Color(0xFF3B82F6); // Blue
  static const Color categoryTechnology = Color(0xFF8B5CF6); // Purple
  static const Color categoryEntertainment = Color(0xFFEC4899); // Pink
  static const Color categorySports = Color(0xFF10B981); // Green
  static const Color categoryHealth = Color(0xFFEF4444); // Red
  static const Color categoryScience = Color(0xFF06B6D4); // Cyan
  static const Color categoryGeneral = Color(0xFF6366F1); // Indigo
}
