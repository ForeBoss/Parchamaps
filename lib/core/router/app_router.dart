import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../features/shell/main_shell.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/feed/presentation/screens/feed_screen.dart';
import '../../features/events/presentation/screens/create_event_screen.dart';
import '../../features/events/presentation/screens/event_detail_screen.dart';
import '../../features/chat/presentation/screens/chats_list_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';

abstract final class AppRoutes {
  static const welcome = '/welcome';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const map = '/map';
  static const feed = '/feed';
  static const createEvent = '/create-event';
  static const chats = '/chats';
  static const profile = '/profile';
  static const settings = '/settings';
  static const editProfile = '/edit-profile';
  static const notifications = '/notifications';

  static String eventDetail(String id) => '/event/$id';
  static String chat(String id) => '/chats/$id';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.welcome,
    redirect: (context, state) {
      final isLoggedIn = authState.isLoggedIn;
      final hasCompletedOnboarding = authState.hasCompletedOnboarding;
      final currentPath = state.matchedLocation;

      final publicRoutes = [
        AppRoutes.welcome,
        AppRoutes.login,
        AppRoutes.onboarding,
      ];
      final isPublicRoute = publicRoutes.contains(currentPath);

      if (!isLoggedIn && !isPublicRoute) {
        return AppRoutes.welcome;
      }

      if (isLoggedIn && !hasCompletedOnboarding && currentPath != AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }

      if (isLoggedIn && hasCompletedOnboarding && isPublicRoute) {
        return AppRoutes.map;
      }

      return null;
    },
    routes: [
      // ── Rutas públicas ──
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Shell principal con bottom nav ──
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.map,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: MapScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.feed,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: FeedScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.chats,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ChatsListScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // ── Rutas fuera del shell ──
      GoRoute(
        path: AppRoutes.createEvent,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const CreateEventScreen(),
      ),
      GoRoute(
        path: '/event/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => EventDetailScreen(
          eventId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/chats/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => ChatScreen(
          chatId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
  );
});
