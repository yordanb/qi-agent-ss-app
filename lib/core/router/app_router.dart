import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/login_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/change_password_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/ss/presentation/screens/ss_list_screen.dart';
import '../../features/esic/presentation/screens/esic_screen.dart';
import '../../features/approval/presentation/screens/approval_pin_screen.dart';
import '../../features/department/presentation/screens/dept_dashboard_screen.dart';
import '../../features/settings/presentation/screens/theme_settings_screen.dart';
import '../../features/manpower/presentation/screens/manpower_list_screen.dart';
import '../../features/manpower/presentation/screens/manpower_form_screen.dart';
import '../../features/manpower/data/models/manpower_item.dart';

/// Notifies GoRouter when auth state changes (login/logout).
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isRedirecting = false;

  RouterNotifier(this._ref) {
    // Listen to auth state changes → trigger router refresh
    _ref.listen(loginNotifierProvider, (_, __) {
      notifyListeners();
    });
  }

  bool get isLoggedIn => _ref.read(loginNotifierProvider).valueOrNull != null;

  String? redirect(BuildContext context, GoRouterState state) {
    final path = state.matchedLocation;
    final loggedIn = isLoggedIn;

    // Prevent redirect loop
    if (_isRedirecting) return null;
    _isRedirecting = true;
    Future.microtask(() => _isRedirecting = false);

    // Not logged in → force to login
    if (!loggedIn && path != '/login') {
      return '/login';
    }

    // Logged in but on login → redirect to dashboard
    if (loggedIn && path == '/login') {
      final user = _ref.read(loginNotifierProvider).valueOrNull;
      return '/dashboard';
    }

    return null;
  }
}

/// Provider for RouterNotifier
final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

/// Provider for GoRouter instance
final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return DashboardScreen(
            nrp: extra['nrp'] ?? '',
            nama: extra['nama'] ?? '',
            isAdmin: extra['is_admin'] ?? false,
          );
        },
      ),
      GoRoute(
        path: '/ss',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return SsListScreen(nrp: extra['nrp'] ?? '');
        },
      ),
      GoRoute(
        path: '/esic',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return EsicScreen(nrp: extra['nrp'] ?? '');
        },
      ),
      GoRoute(
        path: '/approval-pin',
        builder: (context, state) => const ApprovalPinScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ChangePasswordScreen(nrp: extra['nrp'] ?? '');
        },
      ),
      GoRoute(
        path: '/dept-dashboard',
        builder: (context, state) => const DeptDashboardScreen(),
      ),
      GoRoute(
        path: '/theme-settings',
        builder: (context, state) => const ThemeSettingsScreen(),
      ),
      GoRoute(
        path: '/manpower',
        builder: (context, state) => const ManpowerListScreen(),
      ),
      GoRoute(
        path: '/manpower-form',
        builder: (context, state) {
          return ManpowerFormScreen(item: state.extra as ManpowerItem?);
        },
      ),
    ],
  );
});
