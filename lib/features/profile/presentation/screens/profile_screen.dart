import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            title: Text('Perfil', style: AppTypography.headlineMedium),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, size: 24),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),

          // ── Profile header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  // ── Avatar + nombre ──
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'AD',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Andrés D.',
                                  style: AppTypography.headlineSmall,
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.verified_rounded,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Bogotá, Colombia',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            SizedBox(
                              height: 32,
                              child: OutlinedButton(
                                onPressed: () => context.push('/edit-profile'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  textStyle: AppTypography.labelSmall,
                                ),
                                child: const Text('Editar perfil'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Bio ──
                  Text(
                    'Siempre buscando un buen plan. ⚽🎶🍕',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 50.ms),

                  const SizedBox(height: AppSpacing.xl),

                  // ── Stats ──
                  Row(
                    children: [
                      _StatItem(value: '24', label: 'Eventos'),
                      _divider(),
                      _StatItem(value: '156', label: 'Asistidos'),
                      _divider(),
                      _StatItem(value: '4.9', label: 'Reputación'),
                      _divider(),
                      _StatItem(value: '89', label: 'Seguidores'),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms),

                  const SizedBox(height: AppSpacing.xl),

                  // ── Intereses ──
                  _buildInterests()
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 150.ms),

                  const SizedBox(height: AppSpacing.xl),

                  // ── Badges de confianza ──
                  _buildTrustBadges()
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 200.ms),
                ],
              ),
            ),
          ),

          // ── Tabs: Mis eventos / Asistidos ──
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabHeaderDelegate(),
          ),

          // ── Lista de eventos ──
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _ProfileEventCard(index: index)
                      .animate()
                      .fadeIn(
                        duration: 350.ms,
                        delay: (index * 80).ms,
                      )
                      .slideY(begin: 0.03, end: 0);
                },
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.divider,
    );
  }

  Widget _buildInterests() {
    final interests = [
      ('⚽', 'Deportes'),
      ('🎵', 'Música'),
      ('🍕', 'Gastronomía'),
      ('💻', 'Tech'),
      ('🎨', 'Arte'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Intereses', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: interests
              .map((i) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      '${i.$1} ${i.$2}',
                      style: AppTypography.labelMedium,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTrustBadges() {
    final badges = [
      (Icons.verified_user_rounded, 'Verificado', AppColors.primary),
      (Icons.event_available_rounded, 'Puntual', AppColors.success),
      (Icons.star_rounded, 'Top Host', AppColors.warning),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Insignias', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: badges
              .map((b) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: b.$3.withValues(alpha: 0.08),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(b.$1, color: b.$3, size: 24),
                          const SizedBox(height: 6),
                          Text(
                            b.$2,
                            style: AppTypography.labelSmall.copyWith(
                              color: b.$3,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      child: DefaultTabController(
        length: 2,
        child: TabBar(
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.titleSmall,
          tabs: const [
            Tab(text: 'Mis eventos'),
            Tab(text: 'Asistidos'),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _ProfileEventCard extends StatelessWidget {
  final int index;

  const _ProfileEventCard({required this.index});

  static const _events = [
    ('Fútbol 5 - Parque 93', 'Hoy, 6:00 PM', '8/10', Icons.sports_soccer),
    ('Carrera 10K', 'Domingo, 7:00 AM', '45/50', Icons.directions_run_rounded),
    ('Meetup Flutter', 'Sábado, 3:00 PM', '22/30', Icons.code_rounded),
    ('Noche de pizza', 'Viernes, 8:00 PM', '6/8', Icons.local_pizza_rounded),
    ('Yoga al aire libre', 'Mañana, 6:30 AM', '12/15', Icons.self_improvement_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final evt = _events[index];
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(evt.$4, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(evt.$1, style: AppTypography.titleSmall),
                const SizedBox(height: 2),
                Text(
                  evt.$2,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              evt.$3,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
