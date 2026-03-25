import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        title: Text('Notificaciones', style: AppTypography.titleLarge),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Leer todo',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: _notifications().isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: _notifications().length,
              itemBuilder: (context, index) {
                final n = _notifications()[index];
                final isHeader = n['isHeader'] as bool? ?? false;

                if (isHeader) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.sm,
                    ),
                    child: Text(
                      n['title'] as String,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }

                return _NotificationTile(
                  icon: n['icon'] as IconData,
                  color: n['color'] as Color,
                  title: n['title'] as String,
                  body: n['body'] as String,
                  time: n['time'] as String,
                  isRead: n['isRead'] as bool,
                )
                    .animate()
                    .fadeIn(
                      duration: 300.ms,
                      delay: (index * 50).ms,
                    )
                    .slideX(begin: 0.02, end: 0);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Todo al día', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'No tienes notificaciones nuevas',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _notifications() {
    return [
      {'isHeader': true, 'title': 'Hoy'},
      {
        'icon': Icons.person_add_rounded,
        'color': AppColors.primary,
        'title': 'Carlos M. quiere unirse',
        'body': 'Solicitud para "Fútbol 5 - Parque 93"',
        'time': 'Hace 5 min',
        'isRead': false,
      },
      {
        'icon': Icons.check_circle_rounded,
        'color': AppColors.success,
        'title': 'Te aceptaron',
        'body': 'Ya eres parte de "Carrera 10K Domingo"',
        'time': 'Hace 20 min',
        'isRead': false,
      },
      {
        'icon': Icons.chat_bubble_rounded,
        'color': AppColors.secondary,
        'title': 'Nuevo mensaje',
        'body': 'Juan David: "Yo llevo el balón 🎯"',
        'time': 'Hace 1h',
        'isRead': false,
      },
      {'isHeader': true, 'title': 'Ayer'},
      {
        'icon': Icons.event_available_rounded,
        'color': AppColors.categoryDeportes,
        'title': 'Evento cerca de ti',
        'body': '"Yoga al aire libre" empieza mañana a las 6:30 AM',
        'time': 'Ayer',
        'isRead': true,
      },
      {
        'icon': Icons.star_rounded,
        'color': AppColors.warning,
        'title': 'Nueva insignia',
        'body': '¡Ganaste la insignia "Puntual"! 🎉',
        'time': 'Ayer',
        'isRead': true,
      },
      {
        'icon': Icons.people_rounded,
        'color': AppColors.primary,
        'title': 'Evento completo',
        'body': '"Meetup Flutter Bogotá" alcanzó su cupo máximo',
        'time': 'Ayer',
        'isRead': true,
      },
      {'isHeader': true, 'title': 'Esta semana'},
      {
        'icon': Icons.location_on_rounded,
        'color': AppColors.error,
        'title': 'Check-in disponible',
        'body': 'Estás cerca de "Noche de pizza". ¿Has llegado?',
        'time': 'Hace 3 días',
        'isRead': true,
      },
      {
        'icon': Icons.thumb_up_rounded,
        'color': AppColors.primary,
        'title': 'Reacción a tu evento',
        'body': '12 personas marcaron "Me interesa" en tu evento',
        'time': 'Hace 4 días',
        'isRead': true,
      },
    ];
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool isRead;

  const _NotificationTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isRead ? Colors.transparent : AppColors.primary.withValues(alpha: 0.03),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icono ──
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),

            // ── Texto ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight:
                                isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
