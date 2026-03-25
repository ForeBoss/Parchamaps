import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';

class NameStep extends StatelessWidget {
  final String name;
  final String lastName;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onLastNameChanged;

  const NameStep({
    super.key,
    required this.name,
    required this.lastName,
    required this.onNameChanged,
    required this.onLastNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxxl),

          Text(
            '¿Cómo te llamas?',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Así te verán otros en los eventos',
            style: AppTypography.bodyMedium,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.xxxl),

          // ── Nombre ──
          _buildField(
            value: name,
            hint: 'Nombre',
            onChanged: onNameChanged,
            autofocus: true,
            delay: 200,
          ),

          const SizedBox(height: AppSpacing.base),

          // ── Apellido (opcional) ──
          _buildField(
            value: lastName,
            hint: 'Apellido (opcional)',
            onChanged: onLastNameChanged,
            delay: 300,
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Tu apellido solo será visible si tú lo decides',
            style: AppTypography.bodySmall,
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildField({
    required String value,
    required String hint,
    required ValueChanged<String> onChanged,
    bool autofocus = false,
    int delay = 0,
  }) {
    return TextFormField(
      initialValue: value,
      autofocus: autofocus,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.words,
      style: AppTypography.headlineMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: Duration(milliseconds: delay))
        .slideY(
          begin: 0.15,
          end: 0,
          duration: 400.ms,
          delay: Duration(milliseconds: delay),
        );
  }
}
