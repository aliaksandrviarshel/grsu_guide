import 'package:flutter/material.dart';

import '../theme/app_themes.dart';

import 'app_settings_repository.dart';

class AppSettings extends ChangeNotifier {
  final _appSettingsRepository = AppSettingsRepository();

  late bool _isForLeftHanded;
  bool get isForLeftHanded => _isForLeftHanded;

  late ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  late Locale _currentLocale;
  Locale get currentLocale => _currentLocale;

  Future<void> init() async {
    _isForLeftHanded = await _appSettingsRepository.getIsForLeftHanded();
    _currentTheme = await _appSettingsRepository.getTheme();
    _currentLocale = await _appSettingsRepository.getLocale();
  }

  Future<void> toggleForLeftHanded() async {
    await _appSettingsRepository.setIsForLeftHanded(isForLeftHanded);
    _isForLeftHanded = !_isForLeftHanded;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final newTheme =
        _currentTheme == AppThemes.light ? AppThemes.dark : AppThemes.light;
    _appSettingsRepository.setTheme(newTheme);
    _currentTheme = newTheme;
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final targetLocale = _currentLocale.languageCode == 'en'
        ? const Locale('ru')
        : const Locale('en');

    await _appSettingsRepository.setLocale(targetLocale);
    _currentLocale = targetLocale;
    notifyListeners();
  }
}
