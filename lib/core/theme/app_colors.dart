import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Primarios ──
  static const primary = Color(0xFF6C5CE7);
  static const primaryLight = Color(0xFFA29BFE);
  static const primaryDark = Color(0xFF4834D4);

  // ── Secundarios ──
  static const secondary = Color(0xFF00CEC9);
  static const secondaryLight = Color(0xFF81ECEC);
  static const secondaryDark = Color(0xFF00B894);

  // ── Acentos ──
  static const accent = Color(0xFFFD79A8);
  static const accentLight = Color(0xFFFAB1D3);
  static const warning = Color(0xFFFDCB6E);
  static const error = Color(0xFFE17055);
  static const success = Color(0xFF00B894);

  // ── Neutros ──
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFF8F9FE);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF1F2F8);
  static const border = Color(0xFFE8E9F3);
  static const divider = Color(0xFFF0F1F6);

  // ── Texto ──
  static const textPrimary = Color(0xFF2D3436);
  static const textSecondary = Color(0xFF636E72);
  static const textTertiary = Color(0xFFB2BEC3);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnDark = Color(0xFFFFFFFF);

  // ── Dark mode ──
  static const darkBackground = Color(0xFF0D0D14);
  static const darkSurface = Color(0xFF1A1A2E);
  static const darkSurfaceVariant = Color(0xFF242440);
  static const darkBorder = Color(0xFF2D2D4A);
  static const darkTextPrimary = Color(0xFFF5F5F5);
  static const darkTextSecondary = Color(0xFFB0B0C8);
  static const darkTextTertiary = Color(0xFF6C6C8A);

  // ── Categorías de eventos ──
  static const categoryDeportes = Color(0xFF00B894);
  static const categoryMusica = Color(0xFF6C5CE7);
  static const categoryArte = Color(0xFFFD79A8);
  static const categoryGastronomia = Color(0xFFFDCB6E);
  static const categoryNetworking = Color(0xFF0984E3);
  static const categoryGaming = Color(0xFFE17055);
  static const categoryOutdoor = Color(0xFF00CEC9);
  static const categoryCultura = Color(0xFFA29BFE);

  // ── Gradientes ──
  static const primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8B7CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [secondary, Color(0xFF55EFC4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkGradient = LinearGradient(
    colors: [darkBackground, darkSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const onboardingGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Sombras ──
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.15),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}
