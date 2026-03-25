import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../../data/models/user_model.dart';
import 'steps/name_step.dart';
import 'steps/birthdate_step.dart';
import 'steps/interests_step.dart';
import 'steps/photo_step.dart';
import 'steps/location_step.dart';
import 'steps/bio_step.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  int _currentStep = 0;
  final int _totalSteps = 6;

  // Datos del onboarding
  String _name = '';
  String _lastName = '';
  DateTime? _birthDate;
  List<EventCategory> _interests = [];
  String? _photoPath;
  String _bio = '';
  bool _locationGranted = false;

  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  bool get _canContinue {
    switch (_currentStep) {
      case 0:
        return _name.trim().length >= 2;
      case 1:
        return _birthDate != null;
      case 2:
        return _interests.length >= AppConstants.minInterests;
      case 3:
        return true; // foto es opcional
      case 4:
        return true; // bio es opcional
      case 5:
        return true; // location se pide pero no es bloqueante
      default:
        return false;
    }
  }

  void _nextStep() {
    HapticFeedback.lightImpact();
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      HapticFeedback.lightImpact();
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _finishOnboarding() {
    final user = UserModel(
      id: '', // se asigna desde el backend
      name: _name.trim(),
      lastName: _lastName.trim().isEmpty ? null : _lastName.trim(),
      birthDate: _birthDate,
      interests: _interests,
      bio: _bio.trim().isEmpty ? null : _bio.trim(),
      createdAt: DateTime.now(),
    );

    ref.read(authStateProvider.notifier).completeOnboarding(user);
    context.go('/map');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header con progreso ──
            _buildHeader(),

            // ── Steps ──
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NameStep(
                    name: _name,
                    lastName: _lastName,
                    onNameChanged: (v) => setState(() => _name = v),
                    onLastNameChanged: (v) => setState(() => _lastName = v),
                  ),
                  BirthdateStep(
                    birthDate: _birthDate,
                    onDateSelected: (d) => setState(() => _birthDate = d),
                  ),
                  InterestsStep(
                    selected: _interests,
                    onChanged: (v) => setState(() => _interests = v),
                  ),
                  PhotoStep(
                    photoPath: _photoPath,
                    onPhotoSelected: (p) => setState(() => _photoPath = p),
                  ),
                  BioStep(
                    bio: _bio,
                    onChanged: (v) => setState(() => _bio = v),
                  ),
                  LocationStep(
                    isGranted: _locationGranted,
                    onGranted: (v) => setState(() => _locationGranted = v),
                  ),
                ],
              ),
            ),

            // ── Botón continuar ──
            _buildBottomAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.base,
      ),
      child: Column(
        children: [
          // ── Back + Skip ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentStep > 0)
                GestureDetector(
                  onTap: _previousStep,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),

              Text(
                '${_currentStep + 1} de $_totalSteps',
                style: AppTypography.labelMedium,
              ),

              // Skip solo en pasos opcionales
              if (_currentStep == 3 || _currentStep == 4)
                GestureDetector(
                  onTap: _nextStep,
                  child: Text(
                    'Saltar',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: AppSpacing.base),

          // ── Barra de progreso ──
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: List.generate(_totalSteps, (index) {
        final isActive = index <= _currentStep;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: 4,
            margin: EdgeInsets.only(
              right: index < _totalSteps - 1 ? 4 : 0,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomAction() {
    final isLastStep = _currentStep == _totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeightXl,
          key: ValueKey('btn_$_currentStep\_$_canContinue'),
          child: ElevatedButton(
            onPressed: _canContinue ? _nextStep : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _canContinue ? AppColors.primary : AppColors.border,
              foregroundColor:
                  _canContinue ? AppColors.white : AppColors.textTertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              elevation: 0,
            ),
            child: Text(
              isLastStep ? 'Empezar' : 'Continuar',
              style: AppTypography.buttonLarge.copyWith(
                color:
                    _canContinue ? AppColors.white : AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          key: ValueKey('bottom_$_currentStep'),
        )
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms);
  }
}
