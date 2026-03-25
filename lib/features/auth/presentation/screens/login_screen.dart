import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  bool _showOtp = false;
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),

              // ── Back ──
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: AppSpacing.xxl),

              Text(
                'Crea tu cuenta',
                style: AppTypography.displayMedium,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 100.ms)
                  .slideX(begin: -0.1, end: 0, duration: 500.ms),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Elige cómo quieres entrar',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 200.ms),

              const SizedBox(height: AppSpacing.xxxl),

              if (!_showOtp) ...[
                // ── Social login ──
                _SocialButton(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Continuar con Google',
                  color: AppColors.textPrimary,
                  bgColor: AppColors.surfaceVariant,
                  onTap: auth.isLoading
                      ? null
                      : () =>
                          ref.read(authStateProvider.notifier).signInWithGoogle(),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .slideY(begin: 0.1, end: 0, duration: 400.ms),

                const SizedBox(height: AppSpacing.md),

                if (Platform.isIOS)
                  _SocialButton(
                    icon: Icons.apple_rounded,
                    label: 'Continuar con Apple',
                    color: AppColors.white,
                    bgColor: AppColors.textPrimary,
                    onTap: auth.isLoading
                        ? null
                        : () => ref
                            .read(authStateProvider.notifier)
                            .signInWithApple(),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 400.ms)
                      .slideY(begin: 0.1, end: 0, duration: 400.ms),

                if (Platform.isIOS)
                  const SizedBox(height: AppSpacing.md),

                // ── Divider ──
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.base),
                        child: Text(
                          'o',
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 500.ms),

                // ── Phone login ──
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: AppTypography.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Tu número de teléfono',
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 8),
                      child: Text(
                        '+57',
                        style: AppTypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 600.ms)
                    .slideY(begin: 0.1, end: 0, duration: 400.ms),

                const SizedBox(height: AppSpacing.base),

                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeightLg,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ||
                            _phoneController.text.trim().length < 10
                        ? null
                        : () {
                            ref
                                .read(authStateProvider.notifier)
                                .signInWithPhone(_phoneController.text.trim());
                            setState(() => _showOtp = true);
                          },
                    child: auth.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : const Text('Enviar código'),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 700.ms),
              ] else ...[
                // ── OTP verification ──
                Text(
                  'Ingresa el código',
                  style: AppTypography.headlineMedium,
                )
                    .animate()
                    .fadeIn(duration: 400.ms),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Lo enviamos a ${_phoneController.text}',
                  style: AppTypography.bodyMedium,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms),

                const SizedBox(height: AppSpacing.xxl),

                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: AppTypography.displaySmall.copyWith(
                    letterSpacing: 8,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '------',
                    hintStyle: AppTypography.displaySmall.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 8,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms),

                const SizedBox(height: AppSpacing.xl),

                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeightLg,
                  child: ElevatedButton(
                    onPressed: _otpController.text.length == 6
                        ? () => ref
                            .read(authStateProvider.notifier)
                            .verifyOtp(_otpController.text)
                        : null,
                    child: const Text('Verificar'),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 300.ms),

                const SizedBox(height: AppSpacing.base),

                Center(
                  child: TextButton(
                    onPressed: () => setState(() => _showOtp = false),
                    child: const Text('Cambiar número'),
                  ),
                ),
              ],

              if (auth.error != null) ...[
                const SizedBox(height: AppSpacing.base),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(
                    auth.error!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback? onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeightLg,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: color,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: AppTypography.buttonMedium.copyWith(color: color),
        ),
      ),
    );
  }
}
