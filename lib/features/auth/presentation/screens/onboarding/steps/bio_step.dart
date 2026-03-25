import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';

class BioStep extends StatelessWidget {
  final String bio;
  final ValueChanged<String> onChanged;

  const BioStep({
    super.key,
    required this.bio,
    required this.onChanged,
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
            'Cuéntanos de ti',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Una línea sobre qué planes te gustan',
            style: AppTypography.bodyMedium,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),

          const SizedBox(height: AppSpacing.xxl),

          // ── Bio field ──
          TextFormField(
            initialValue: bio,
            onChanged: onChanged,
            maxLength: 150,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            style: AppTypography.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Ej: futbolero de domingo, busco planes outdoor 🏔️',
              hintStyle: AppTypography.bodyLarge.copyWith(
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.surfaceVariant,
              contentPadding: const EdgeInsets.all(AppSpacing.lg),
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
              counterStyle: AppTypography.bodySmall,
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .slideY(begin: 0.15, end: 0, duration: 400.ms),

          const Spacer(),

          Center(
            child: Text(
              'Esto es opcional, puedes editarlo después',
              style: AppTypography.bodySmall,
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 400.ms),

          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }
}
