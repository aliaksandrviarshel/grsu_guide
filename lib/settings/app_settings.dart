import 'package:flutter/material.dart';

import '../main.dart';

import 'app_settings_repository.dart';

class AppSettings extends ChangeNotifier {
  final _appSettingsRepository = AppSettingsRepository();

  late bool _isForLeftHanded;
  bool get isForLeftHanded => _isForLeftHanded;

  late ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  Future<void> init() async {
    _isForLeftHanded = await _appSettingsRepository.getIsForLeftHanded();
    _currentTheme = await _appSettingsRepository.getTheme();
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
}
