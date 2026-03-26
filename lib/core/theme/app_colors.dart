import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Primarios — Azul urbano (confianza, navegación, discovery) ──
  static const primary = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF5E92F3);
  static const primaryDark = Color(0xFF0D47A1);

  // ── Secundarios — Coral cálido (acción social, CTA) ──
  static const secondary = Color(0xFFFF6B4A);
  static const secondaryLight = Color(0xFFFF9E7A);
  static const secondaryDark = Color(0xFFE55335);

  // ── Acentos — Teal fresco (confirmaciones, highlights) ──
  static const accent = Color(0xFF14B8A6);
  static const accentLight = Color(0xFF5EEAD4);
  static const warning = Color(0xFFF4B740);
  static const error = Color(0xFFD64545);
  static const success = Color(0xFF1F9D68);

  // ── Neutros — Marfil urbano (layout base premium) ──
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7F6F2);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFEEF1F5);
  static const border = Color(0xFFD9E0E8);
  static const divider = Color(0xFFE8EDF3);

  // ── Texto ──
  static const textPrimary = Color(0xFF14213D);
  static const textSecondary = Color(0xFF5C677D);
  static const textTertiary = Color(0xFFA3AEBB);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnDark = Color(0xFFFFFFFF);

  // ── Dark mode — Noche urbana profunda ──
  static const darkBackground = Color(0xFF0A0E1A);
  static const darkSurface = Color(0xFF131929);
  static const darkSurfaceVariant = Color(0xFF1E2740);
  static const darkBorder = Color(0xFF2A3450);
  static const darkTextPrimary = Color(0xFFF0F4FF);
  static const darkTextSecondary = Color(0xFF8A9BBF);
  static const darkTextTertiary = Color(0xFF4A5775);

  // ── Categorías de eventos ──
  static const categoryDeportes = Color(0xFF22C55E);
  static const categoryMusica = Color(0xFF8B5CF6);
  static const categoryArte = Color(0xFFEC4899);
  static const categoryGastronomia = Color(0xFFF59E0B);
  static const categoryNetworking = Color(0xFF2563EB);
  static const categoryGaming = Color(0xFF06B6D4);
  static const categoryOutdoor = Color(0xFF10B981);
  static const categoryCultura = Color(0xFFA855F7);

  // ── Gradientes ──
  static const primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF2196F3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [secondary, Color(0xFFFF8C6F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkGradient = LinearGradient(
    colors: [darkBackground, darkSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const onboardingGradient = LinearGradient(
    colors: [primary, secondary],
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
