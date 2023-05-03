import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  final _isForLeftHandedKey = 'is_for_left_handed';
  final isForLeftHanded = false.obs;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    isForLeftHanded.value = prefs.getBool(_isForLeftHandedKey) ?? false;
  }

  Future<bool> toggleForLeftHanded() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isForLeftHandedKey, !isForLeftHanded.value);
    isForLeftHanded.value = !isForLeftHanded.value;
    return isForLeftHanded.value;
  }
}
