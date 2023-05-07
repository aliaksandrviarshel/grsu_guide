import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_themes.dart';

class AppSettingsRepository {
  final _isForLeftHandedKey = 'is_for_left_handed';
  final _themeKey = 'theme';
  final _localeKey = 'locale';

  Future<bool> getIsForLeftHanded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isForLeftHandedKey) ?? false;
  }

  Future<void> updateIsForLeftHanded(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isForLeftHandedKey, !value);
  }

  Future<ThemeData> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_themeKey) ?? 'light') == 'light'
        ? AppThemes.light
        : AppThemes.dark;
  }

  Future<void> updateTheme(ThemeData theme) async {
    var prefs = await SharedPreferences.getInstance();
    final newTheme = theme == AppThemes.light ? 'light' : 'dark';
    await prefs.setString(_themeKey, newTheme);
  }

  Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_localeKey) ?? 'ru') == 'ru'
        ? const Locale('ru')
        : const Locale('en');
  }

  Future<void> updateLocale(Locale targetLocale) async {
    var prefs = await SharedPreferences.getInstance();
    final newLocale = targetLocale.languageCode == 'en' ? 'en' : 'ru';
    await prefs.setString(_localeKey, newLocale);
  }
}
