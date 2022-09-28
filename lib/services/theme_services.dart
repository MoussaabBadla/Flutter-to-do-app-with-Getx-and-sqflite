import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'IsDarkMode';

  _saveThemeFrombox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFrombox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme => _loadThemeFrombox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(theme);
    _saveThemeFrombox(!_loadThemeFrombox());
  }
}
