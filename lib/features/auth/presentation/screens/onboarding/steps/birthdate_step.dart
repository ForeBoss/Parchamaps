import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../../../core/constants/app_constants.dart';

class BirthdateStep extends StatefulWidget {
  final DateTime? birthDate;
  final ValueChanged<DateTime> onDateSelected;

  const BirthdateStep({
    super.key,
    required this.birthDate,
    required this.onDateSelected,
  });

  @override
  State<BirthdateStep> createState() => _BirthdateStepState();
}

class _BirthdateStepState extends State<BirthdateStep> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.birthDate ??
        DateTime(DateTime.now().year - 20, 1, 1);
  }

  int get _age {
    final now = DateTime.now();
    var age = now.year - _selectedDate.year;
    if (now.month < _selectedDate.month ||
        (now.month == _selectedDate.month && now.day < _selectedDate.day)) {
      age--;
    }
    return age;
  }

  bool get _isValidAge =>
      _age >= AppConstants.minAge && _age <= AppConstants.maxAge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxxl),

          Text(
            '¿Cuándo naciste?',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Tu edad aparecerá en tu perfil',
            style: AppTypography.bodyMedium,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),

          const SizedBox(height: AppSpacing.xxl),

          // ── Age display ──
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: _isValidAge
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                '$_age años',
                style: AppTypography.headlineLarge.copyWith(
                  color: _isValidAge ? AppColors.primary : AppColors.error,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

          if (!_isValidAge) ...[
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                'Debes tener al menos ${AppConstants.minAge} años',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.xxl),

          // ── Date Picker ──
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime(1920),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) {
                  setState(() => _selectedDate = date);
                  if (_isValidAge) {
                    widget.onDateSelected(date);
                  }
                },
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 300.ms)
                .slideY(begin: 0.1, end: 0, duration: 500.ms),
          ),

          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }
}
