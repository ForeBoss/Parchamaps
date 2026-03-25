import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _locationSharing = false;
  bool _chatSounds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Configuración', style: AppTypography.titleLarge),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cuenta ──
            _sectionTitle('Cuenta'),
            _settingsTile(
              icon: Icons.person_outline_rounded,
              title: 'Información personal',
              subtitle: 'Nombre, email, teléfono',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.shield_outlined,
              title: 'Privacidad',
              subtitle: 'Quién puede ver tu perfil',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.lock_outline_rounded,
              title: 'Seguridad',
              subtitle: 'Contraseña y autenticación',
              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Preferencias ──
            _sectionTitle('Preferencias'),
            _toggleTile(
              icon: Icons.dark_mode_outlined,
              title: 'Modo oscuro',
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            ),
            _toggleTile(
              icon: Icons.notifications_outlined,
              title: 'Notificaciones push',
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
            ),
            _toggleTile(
              icon: Icons.location_on_outlined,
              title: 'Compartir ubicación',
              subtitle: 'Solo cuando uses la app',
              value: _locationSharing,
              onChanged: (v) => setState(() => _locationSharing = v),
            ),
            _toggleTile(
              icon: Icons.volume_up_outlined,
              title: 'Sonidos de chat',
              value: _chatSounds,
              onChanged: (v) => setState(() => _chatSounds = v),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Descubrimiento ──
            _sectionTitle('Descubrimiento'),
            _settingsTile(
              icon: Icons.explore_outlined,
              title: 'Radio de búsqueda',
              subtitle: '10 km',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.category_outlined,
              title: 'Categorías preferidas',
              subtitle: 'Deportes, Música, Tech, +2',
              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Soporte ──
            _sectionTitle('Soporte'),
            _settingsTile(
              icon: Icons.help_outline_rounded,
              title: 'Centro de ayuda',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.report_outlined,
              title: 'Reportar un problema',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.description_outlined,
              title: 'Términos y condiciones',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.policy_outlined,
              title: 'Política de privacidad',
              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Versión ──
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'ParchaMaps v1.0.0',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Cerrar sesión ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _confirmLogout,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: const Text('Cerrar sesión'),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Eliminar cuenta ──
            Center(
              child: TextButton(
                onPressed: _confirmDelete,
                child: Text(
                  'Eliminar mi cuenta',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textTertiary,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, size: 20, color: AppColors.textSecondary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleSmall),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms);
  }

  Widget _toggleTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(icon, size: 20, color: AppColors.textSecondary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms);
  }

  void _confirmLogout() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('¿Cerrar sesión?'),
        content: const Text('Tendrás que volver a iniciar sesión.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              // auth provider signOut
            },
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('¿Eliminar tu cuenta?'),
        content: const Text(
          'Esta acción es irreversible. Se borrarán todos tus datos, '
          'eventos y mensajes.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              // delete account logic
            },
            child: const Text('Eliminar cuenta'),
          ),
        ],
      ),
    );
  }
}
