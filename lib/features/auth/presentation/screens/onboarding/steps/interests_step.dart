import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../data/models/user_model.dart';

class InterestsStep extends StatelessWidget {
  final List<EventCategory> selected;
  final ValueChanged<List<EventCategory>> onChanged;

  const InterestsStep({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  void _toggle(EventCategory category) {
    HapticFeedback.selectionClick();
    final updated = List<EventCategory>.from(selected);
    if (updated.contains(category)) {
      updated.remove(category);
    } else if (updated.length < AppConstants.maxInterests) {
      updated.add(category);
    }
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxxl),

          Text(
            '¿Qué te interesa?',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Elige al menos ${AppConstants.minInterests} • ${selected.length} de ${AppConstants.maxInterests}',
            style: AppTypography.bodyMedium.copyWith(
              color: selected.length >= AppConstants.minInterests
                  ? AppColors.success
                  : AppColors.textSecondary,
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),

          const SizedBox(height: AppSpacing.xxl),

          // ── Grid de intereses ──
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: EventCategory.values.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  final isSelected = selected.contains(category);

                  return _InterestChip(
                    category: category,
                    isSelected: isSelected,
                    onTap: () => _toggle(category),
                  )
                      .animate()
                      .fadeIn(
                        duration: 400.ms,
                        delay: Duration(milliseconds: 50 * index),
                      )
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        duration: 400.ms,
                        delay: Duration(milliseconds: 50 * index),
                      );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final EventCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _InterestChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? category.color.withValues(alpha: 0.15)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isSelected ? category.color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 20,
              color: isSelected ? category.color : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              category.label,
              style: AppTypography.labelLarge.copyWith(
                color: isSelected ? category.color : AppColors.textPrimary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: category.color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
