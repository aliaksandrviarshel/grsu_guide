import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AppSettingsRepository {
  final _isForLeftHandedKey = 'is_for_left_handed';
  final _themeKey = 'theme';

  Future<bool> getIsForLeftHanded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isForLeftHandedKey) ?? false;
  }

  Future<void> setIsForLeftHanded(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isForLeftHandedKey, !value);
  }

  Future<ThemeData> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_themeKey) ?? 'light') == 'light'
        ? AppThemes.light
        : AppThemes.dark;
  }

  Future<void> setTheme(ThemeData theme) async {
    var prefs = await SharedPreferences.getInstance();
    final newTheme = theme == AppThemes.light ? 'light' : 'dark';
    await prefs.setString(_themeKey, newTheme);
  }
}
