import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeViewModel extends StateNotifier<ThemeMode> {
  ThemeViewModel() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const _themeBox = 'themeBox';
  static const _themeKey = 'isDarkMode';

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_themeBox);
    final isDark = box.get(_themeKey, defaultValue: false);
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final box = await Hive.openBox(_themeBox);
    final isDark = state == ThemeMode.dark;
    await box.put(_themeKey, !isDark);
    state = !isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider = StateNotifierProvider<ThemeViewModel, ThemeMode>(
  (ref) => ThemeViewModel(),
);
