import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/ss_list_screen.dart';
import 'screens/esic_screen.dart';
import 'screens/approval_pin_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/dept_dashboard_screen.dart';
import 'services/api_service.dart';

void main() => runApp(const QIApp());

class QIApp extends StatelessWidget {
  const QIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quality Innovation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blueGrey,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(

  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final nrp = extra['nrp'] ?? ApiService.authNrp ?? '';
        final nama = extra['nama'] ?? '';
        final isAdmin = extra['is_admin'] ?? ApiService.isAdmin;
        print('[GO-ROUTER] /dashboard nrp=$nrp isAdmin=$isAdmin');
        return DashboardScreen(
          nrp: nrp,
          nama: nama,
          isAdmin: isAdmin,
        );
      },
    ),
    GoRoute(
      path: '/ss',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return SsListScreen(
          nrp: extra['nrp'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/esic',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return EsicScreen(
          nrp: extra['nrp'] ?? '',
          snapshots: extra['snapshots'] ?? [],
          isLoading: extra['isLoading'] ?? false,
        );
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
  ],
);
