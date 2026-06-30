import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeColor { indigo, teal, cyan }

class AppThemeData {
  final String name;
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color accent;
  final ColorScheme colorScheme;

  const AppThemeData({
    required this.name,
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.accent,
    required this.colorScheme,
  });
}

const Map<AppThemeColor, AppThemeData> appThemes = {
  AppThemeColor.indigo: AppThemeData(
    name: 'Indigo',
    primary: Color(0xFF3F51B5),
    primaryDark: Color(0xFF283593),
    primaryLight: Color(0xFF7986CB),
    accent: Color(0xFF536DFE),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3F51B5),
      onPrimary: Colors.white,
      secondary: Color(0xFF536DFE),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1A237E),
      error: Colors.red,
      onError: Colors.white,
    ),
  ),
  AppThemeColor.teal: AppThemeData(
    name: 'Teal',
    primary: Color(0xFF00897B),
    primaryDark: Color(0xFF00695C),
    primaryLight: Color(0xFF4DB6AC),
    accent: Color(0xFF1DE9B6),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00897B),
      onPrimary: Colors.white,
      secondary: Color(0xFF1DE9B6),
      onSecondary: Color(0xFF004D40),
      surface: Colors.white,
      onSurface: Color(0xFF004D40),
      error: Colors.red,
      onError: Colors.white,
    ),
  ),
  AppThemeColor.cyan: AppThemeData(
    name: 'Cyan',
    primary: Color(0xFF0393EA),
    primaryDark: Color(0xFF02142F),
    primaryLight: Color(0xFF64C8FF),
    accent: Color(0xFF01CFF4),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0393EA),
      onPrimary: Colors.white,
      secondary: Color(0xFF01CFF4),
      onSecondary: Color(0xFF001F3F),
      surface: Colors.white,
      onSurface: Color(0xFF02142F),
      error: Colors.red,
      onError: Colors.white,
    ),
  ),
};

class ThemeNotifier extends ChangeNotifier {
  AppThemeColor _current = AppThemeColor.indigo;
  SharedPreferences? _prefs;

  AppThemeColor get current => _current;
  AppThemeData get themeData => appThemes[_current]!;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs?.getString('app_theme') ?? 'indigo';
    _current = AppThemeColor.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppThemeColor.indigo,
    );
    notifyListeners();
  }

  Future<void> setTheme(AppThemeColor theme) async {
    _current = theme;
    await _prefs?.setString('app_theme', theme.name);
    notifyListeners();
  }

  ThemeData get lightTheme {
    final t = themeData;
    return ThemeData(
      useMaterial3: true,
      colorScheme: t.colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: t.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: t.primary.withOpacity(0.15),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(fontSize: 11)),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});
