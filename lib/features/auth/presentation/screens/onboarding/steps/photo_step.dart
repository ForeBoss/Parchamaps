import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';

class PhotoStep extends StatelessWidget {
  final String? photoPath;
  final ValueChanged<String?> onPhotoSelected;

  const PhotoStep({
    super.key,
    required this.photoPath,
    required this.onPhotoSelected,
  });

  Future<void> _pickPhoto(BuildContext context) async {
    final picker = ImagePicker();

    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _PickOption(
                icon: Icons.camera_alt_rounded,
                label: 'Tomar foto',
                onTap: () async {
                  Navigator.pop(ctx);
                  final file = await picker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1024,
                    maxHeight: 1024,
                    imageQuality: 85,
                  );
                  if (file != null) onPhotoSelected(file.path);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              _PickOption(
                icon: Icons.photo_library_rounded,
                label: 'Elegir de galería',
                onTap: () async {
                  Navigator.pop(ctx);
                  final file = await picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1024,
                    maxHeight: 1024,
                    imageQuality: 85,
                  );
                  if (file != null) onPhotoSelected(file.path);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
            'Tu foto de perfil',
            style: AppTypography.displaySmall,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Ayuda a que te reconozcan en los eventos',
            style: AppTypography.bodyMedium,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),

          const Spacer(),

          // ── Avatar preview ──
          Center(
            child: GestureDetector(
              onTap: () => _pickPhoto(context),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: photoPath != null
                        ? AppColors.primary
                        : AppColors.border,
                    width: 3,
                  ),
                  image: photoPath != null
                      ? DecorationImage(
                          image: FileImage(File(photoPath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: photoPath != null
                      ? AppColors.elevatedShadow
                      : null,
                ),
                child: photoPath == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_a_photo_rounded,
                            size: 40,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Agregar foto',
                            style: AppTypography.labelMedium,
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1, 1),
                duration: 500.ms,
                delay: 200.ms,
              ),

          if (photoPath != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: TextButton.icon(
                onPressed: () => onPhotoSelected(null),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Cambiar foto'),
              ),
            ),
          ],

          const Spacer(),

          Center(
            child: Text(
              'Puedes agregar una después si prefieres',
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

class _PickOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.base,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: AppSpacing.md),
            Text(label, style: AppTypography.titleMedium),
          ],
        ),
      ),
    );
  }
}
