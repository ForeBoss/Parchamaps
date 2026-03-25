import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/router/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6C5CE7),
              Color(0xFF8B7CF6),
              Color(0xFFA29BFE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // ── Logo ──
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusXxl),
                  ),
                  child: const Icon(
                    Icons.explore_rounded,
                    size: 56,
                    color: AppColors.white,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: AppSpacing.xxl),

                // ── Titulo ──
                Text(
                  'ParchaMaps',
                  style: AppTypography.displayLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Planes reales cerca de ti',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.white.withValues(alpha: 0.85),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms),

                const Spacer(flex: 2),

                // ── Features rápidas ──
                ..._buildFeatures(),

                const Spacer(),

                // ── CTA ──
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeightXl,
                  child: ElevatedButton(
                    onPressed: () => context.push(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Empezar',
                      style: AppTypography.buttonLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 800.ms)
                    .slideY(begin: 0.2, end: 0, duration: 500.ms),

                const SizedBox(height: AppSpacing.md),

                Text(
                  'Al continuar aceptas nuestros términos de uso',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 1000.ms),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFeatures() {
    final features = [
      (Icons.map_rounded, 'Descubre eventos en tu zona'),
      (Icons.people_rounded, 'Únete a planes reales'),
      (Icons.verified_rounded, 'Asistencia verificada'),
    ];

    return features.asMap().entries.map((entry) {
      final index = entry.key;
      final feature = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.15),
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                feature.$1,
                color: AppColors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                feature.$2,
                style: AppTypography.titleSmall.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: 500.ms,
            delay: Duration(milliseconds: 500 + (index * 100)),
          )
          .slideX(
            begin: -0.15,
            end: 0,
            duration: 500.ms,
            delay: Duration(milliseconds: 500 + (index * 100)),
          );
    }).toList();
  }
}
