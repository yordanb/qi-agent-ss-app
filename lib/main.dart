import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = ThemeNotifier();
  await themeNotifier.init();

  runApp(
    ProviderScope(
      overrides: [themeNotifierProvider.overrideWith((ref) => themeNotifier)],
      child: const QIApp(),
    ),
  );
}

class QIApp extends ConsumerWidget {
  const QIApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      title: 'QI',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
