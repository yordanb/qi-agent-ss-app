import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qi_agent_ss/core/theme/app_theme.dart';

void main() {
  group('App Theme', () {
    test('default theme is indigo', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final themeNotifier = container.read(themeNotifierProvider);
      expect(themeNotifier.current, AppThemeColor.indigo);
    });

    test('theme data has correct brightness', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final themeNotifier = container.read(themeNotifierProvider);
      expect(themeNotifier.themeData.colorScheme.brightness, Brightness.light);
    });

    test('theme data has correct name', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final themeNotifier = container.read(themeNotifierProvider);
      expect(themeNotifier.themeData.name, 'Indigo');
    });
  });
}
