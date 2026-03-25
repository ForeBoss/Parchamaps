import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';

// ══════════════════════════════════════════════════════════════
//  Estado de autenticación
// ══════════════════════════════════════════════════════════════

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final bool isLoggedIn;
  final bool hasCompletedOnboarding;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.isLoggedIn = false,
    this.hasCompletedOnboarding = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? isLoggedIn,
    bool? hasCompletedOnboarding,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      error: error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Integrar con Supabase Auth
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        hasCompletedOnboarding: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        hasCompletedOnboarding: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signInWithPhone(String phone) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        hasCompletedOnboarding: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void completeOnboarding(UserModel user) {
    state = state.copyWith(
      user: user,
      hasCompletedOnboarding: true,
    );
  }

  void updateUser(UserModel user) {
    state = state.copyWith(user: user);
  }

  Future<void> signOut() async {
    state = const AuthState();
  }
}

final authStateProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authStateProvider).user;
});
