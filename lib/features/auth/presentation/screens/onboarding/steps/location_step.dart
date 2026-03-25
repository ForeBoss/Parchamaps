import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';

class LocationStep extends StatefulWidget {
  final bool isGranted;
  final ValueChanged<bool> onGranted;

  const LocationStep({
    super.key,
    required this.isGranted,
    required this.onGranted,
  });

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _requestLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Activa la ubicación en tu dispositivo';
          _isLoading = false;
        });
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Necesitamos tu ubicación para mostrarte eventos cercanos';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
              'La ubicación está bloqueada. Actívala en Ajustes.';
          _isLoading = false;
        });
        return;
      }

      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      widget.onGranted(true);
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _errorMessage = 'No pudimos obtener tu ubicación';
        _isLoading = false;
      });
    }
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
            'Tu ubicación',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Para mostrarte eventos cerca de ti',
            style: AppTypography.bodyMedium,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),

          const Spacer(),

          // ── Ilustración ──
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: widget.isGranted
                  ? Column(
                      key: const ValueKey('granted'),
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle_rounded,
                            size: 64,
                            color: AppColors.success,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          '¡Listo! Ya podemos mostrarte\neventos cercanos',
                          textAlign: TextAlign.center,
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      key: const ValueKey('not_granted'),
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            size: 64,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          width: double.infinity,
                          height: AppSpacing.buttonHeightLg,
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _requestLocation,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.white,
                                    ),
                                  )
                                : const Icon(Icons.my_location_rounded),
                            label: Text(
                              _isLoading
                                  ? 'Obteniendo...'
                                  : 'Activar ubicación',
                            ),
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1, 1),
                duration: 500.ms,
              ),

          const Spacer(),

          // ── Privacidad ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.base),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Tu ubicación nunca se comparte con otros usuarios. Solo la usamos para mostrarte eventos.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
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
