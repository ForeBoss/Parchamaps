import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/data/models/user_model.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _capacityController = TextEditingController();
  EventCategory _category = EventCategory.deportes;
  DateTime _startDate = DateTime.now().add(const Duration(hours: 2));
  bool _chatEnabled = true;
  bool _requiresApproval = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Crear evento', style: AppTypography.headlineMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.base),
            child: TextButton(
              onPressed: _titleController.text.trim().isNotEmpty
                  ? _createEvent
                  : null,
              child: Text(
                'Publicar',
                style: AppTypography.labelLarge.copyWith(
                  color: _titleController.text.trim().isNotEmpty
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Sección: Info básica ──
            _buildSectionTitle('¿Qué plan es?', 0),
            const SizedBox(height: AppSpacing.base),

            // Título
            TextFormField(
              controller: _titleController,
              maxLength: 80,
              textCapitalization: TextCapitalization.sentences,
              style: AppTypography.headlineMedium,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Ej: Fútbol 5 en el parque',
                hintStyle: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                counterStyle: AppTypography.bodySmall,
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: BorderSide.none,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: AppSpacing.base),

            // Descripción
            TextFormField(
              controller: _descController,
              maxLength: 500,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: AppTypography.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Describe el plan...',
                hintStyle: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textTertiary,
                ),
                counterStyle: AppTypography.bodySmall,
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: BorderSide.none,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Categoría ──
            _buildSectionTitle('Categoría', 1),
            const SizedBox(height: AppSpacing.md),
            _buildCategorySelector()
                .animate()
                .fadeIn(duration: 400.ms, delay: 150.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Cuándo ──
            _buildSectionTitle('¿Cuándo?', 2),
            const SizedBox(height: AppSpacing.md),
            _buildDateTimePicker()
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Dónde ──
            _buildSectionTitle('¿Dónde?', 3),
            const SizedBox(height: AppSpacing.md),
            _buildLocationPicker()
                .animate()
                .fadeIn(duration: 400.ms, delay: 250.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Cupos ──
            _buildSectionTitle('Cupos', 4),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _capacityController,
              keyboardType: TextInputType.number,
              style: AppTypography.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Sin límite',
                hintStyle: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textTertiary,
                ),
                prefixIcon: const Icon(Icons.people_outline_rounded),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: BorderSide.none,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 300.ms),

            const SizedBox(height: AppSpacing.xl),

            // ── Configuración ──
            _buildSectionTitle('Configuración', 5),
            const SizedBox(height: AppSpacing.md),

            _buildToggle(
              'Chat habilitado',
              'Permite que los interesados te escriban',
              Icons.chat_bubble_outline_rounded,
              _chatEnabled,
              (v) => setState(() => _chatEnabled = v),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 350.ms),

            const SizedBox(height: AppSpacing.md),

            _buildToggle(
              'Requiere aprobación',
              'Tú decides quién puede unirse',
              Icons.verified_user_outlined,
              _requiresApproval,
              (v) => setState(() => _requiresApproval = v),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 400.ms),

            const SizedBox(height: AppSpacing.huge),

            // ── Publicar ──
            SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeightXl,
              child: ElevatedButton(
                onPressed: _titleController.text.trim().isNotEmpty
                    ? _createEvent
                    : null,
                child: const Text('Publicar evento'),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 450.ms),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int section) {
    return Text(
      title,
      style: AppTypography.headlineSmall,
    );
  }

  Widget _buildCategorySelector() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: EventCategory.values.map((cat) {
        final isSelected = _category == cat;
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _category = cat);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? cat.color.withValues(alpha: 0.15)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: isSelected ? cat.color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(cat.icon, size: 18, color: isSelected ? cat.color : AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  cat.label,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? cat.color : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateTimePicker() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _startDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null && mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(_startDate),
          );
          if (time != null) {
            setState(() {
              _startDate = DateTime(
                date.year, date.month, date.day,
                time.hour, time.minute,
              );
            });
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                  style: AppTypography.titleMedium,
                ),
                Text(
                  '${_startDate.hour.toString().padLeft(2, '0')}:${_startDate.minute.toString().padLeft(2, '0')}',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    return GestureDetector(
      onTap: () {
        // TODO: abrir selector de ubicación en mapa
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: const Icon(
                Icons.add_location_alt_rounded,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Elige la ubicación en el mapa',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  void _createEvent() {
    // TODO: enviar al backend
    Navigator.pop(context);
  }
}
