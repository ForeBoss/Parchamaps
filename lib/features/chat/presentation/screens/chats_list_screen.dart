import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Chats', style: AppTypography.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: _chatsList().isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: _chatsList().length,
              itemBuilder: (context, index) {
                final chat = _chatsList()[index];
                return _ChatTile(
                  title: chat['title'] as String,
                  lastMessage: chat['lastMessage'] as String,
                  time: chat['time'] as String,
                  unread: chat['unread'] as int,
                  isActive: chat['isActive'] as bool,
                  categoryColor: chat['color'] as Color,
                  icon: chat['icon'] as IconData,
                  onTap: () {},
                )
                    .animate()
                    .fadeIn(
                      duration: 350.ms,
                      delay: (index * 60).ms,
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
                Icons.chat_bubble_outline_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Sin chats aún',
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Únete a un evento para participar en su chat grupal',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _chatsList() {
    return [
      {
        'title': 'Fútbol 5 - Parque 93',
        'lastMessage': 'Juan: Yo llevo el balón 🎯',
        'time': 'Ahora',
        'unread': 3,
        'isActive': true,
        'color': AppColors.categoryDeportes,
        'icon': Icons.sports_soccer,
      },
      {
        'title': 'Concierto Morat',
        'lastMessage': 'Nos vemos en la entrada norte',
        'time': '5 min',
        'unread': 1,
        'isActive': true,
        'color': AppColors.categoryMusica,
        'icon': Icons.music_note_rounded,
      },
      {
        'title': 'Taller de cerámica',
        'lastMessage': 'María: ¿Alguien lleva materiales extra?',
        'time': '15 min',
        'unread': 0,
        'isActive': false,
        'color': AppColors.categoryArte,
        'icon': Icons.palette_rounded,
      },
      {
        'title': 'Carrera 10K Domingo',
        'lastMessage': 'Recuerden hidratarse bien antes 💧',
        'time': '2h',
        'unread': 0,
        'isActive': false,
        'color': AppColors.categoryDeportes,
        'icon': Icons.directions_run_rounded,
      },
      {
        'title': 'Meetup Flutter Bogotá',
        'lastMessage': 'Carlos: ¿Confirman asistencia?',
        'time': 'Ayer',
        'unread': 0,
        'isActive': false,
        'color': AppColors.categoryNetworking,
        'icon': Icons.code_rounded,
      },
    ];
  }
}

class _ChatTile extends StatelessWidget {
  final String title;
  final String lastMessage;
  final String time;
  final int unread;
  final bool isActive;
  final Color categoryColor;
  final IconData icon;
  final VoidCallback onTap;

  const _ChatTile({
    required this.title,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.isActive,
    required this.categoryColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // ── Avatar del evento ──
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(icon, color: categoryColor, size: 26),
                ),
                if (isActive)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),

            // ── Text ──
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
                                unread > 0 ? FontWeight.w700 : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: AppTypography.labelSmall.copyWith(
                          color: unread > 0
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          fontWeight:
                              unread > 0 ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: AppTypography.bodySmall.copyWith(
                            color: unread > 0
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: unread > 0
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unread > 0) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unread',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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
