import 'package:get/get.dart';

import 'package:grsu_guide/navigation/app_drawer.dart';
import 'package:grsu_guide/navigation/nav_wheel/nav_wheel.dart';
import 'package:grsu_guide/settings/app_settings.dart';

class AppDrawerFactory {
  final _settings = Get.find<AppSettings>();

  AppDrawer? drawer() {
    return _settings.isForLeftHanded ? null : const AppDrawer();
  }

  AppDrawer? endDrawer() {
    return _settings.isForLeftHanded
        ? const AppDrawer(alignment: NavWheelAlignment.right)
        : null;
  }
}
