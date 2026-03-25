import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Andrés');
  final _lastNameController = TextEditingController(text: 'D.');
  final _bioController = TextEditingController(
    text: 'Siempre buscando un buen plan. ⚽🎶🍕',
  );
  File? _photo;
  final _selectedInterests = <EventCategory>{
    EventCategory.deportes,
    EventCategory.musica,
    EventCategory.gastronomia,
    EventCategory.networking,
    EventCategory.arte,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Editar perfil', style: AppTypography.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: TextButton(
              onPressed: _save,
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Foto ──
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        image: _photo != null
                            ? DecorationImage(
                                image: FileImage(_photo!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _photo == null
                          ? const Center(
                              child: Text(
                                'AD',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Nombre ──
            _label('Nombre'),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _nameController,
              style: AppTypography.bodyLarge,
              decoration: const InputDecoration(hintText: 'Tu nombre'),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 50.ms),

            const SizedBox(height: AppSpacing.lg),

            _label('Apellido'),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _lastNameController,
              style: AppTypography.bodyLarge,
              decoration: const InputDecoration(hintText: 'Tu apellido'),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms),

            const SizedBox(height: AppSpacing.lg),

            // ── Bio ──
            _label('Bio'),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _bioController,
              style: AppTypography.bodyLarge,
              maxLines: 3,
              maxLength: 150,
              decoration: const InputDecoration(
                hintText: 'Cuéntanos sobre ti...',
                alignLabelWithHint: true,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 150.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Intereses ──
            _label('Intereses'),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Selecciona entre 3 y 8 intereses',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: EventCategory.values.map((cat) {
                final selected = _selectedInterests.contains(cat);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        if (_selectedInterests.length > 3) {
                          _selectedInterests.remove(cat);
                        }
                      } else {
                        if (_selectedInterests.length < 8) {
                          _selectedInterests.add(cat);
                        }
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? cat.color.withValues(alpha: 0.15)
                          : AppColors.surfaceVariant,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                      border: selected
                          ? Border.all(
                              color: cat.color.withValues(alpha: 0.4), width: 1.5)
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(cat.icon, size: 16, color: selected ? cat.color : AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(
                          cat.label,
                          style: AppTypography.labelMedium.copyWith(
                            color: selected
                                ? cat.color
                                : AppColors.textSecondary,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                        if (selected) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: cat.color,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: AppTypography.titleSmall.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final source = await showCupertinoModalPopup<ImageSource>(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Tomar foto'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Elegir de galería'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
    );
    if (source == null) return;
    final xfile = await picker.pickImage(source: source, maxWidth: 800);
    if (xfile != null) {
      setState(() => _photo = File(xfile.path));
    }
  }

  void _save() {
    // Aquí iría la lógica de guardar con el provider
    Navigator.pop(context);
  }
}
