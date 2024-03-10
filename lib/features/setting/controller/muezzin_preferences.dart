import 'package:shared_preferences/shared_preferences.dart';

class MuezzinPreferences {
  static const _muezzinKey = 'muezzin';
  static Future<String?> getMuezzin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_muezzinKey);
  }

  static Future<void> setMuezzin(String muezzin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_muezzinKey, muezzin);
  }
}


class MuezzinPreferencesFajr {
  static const _muezzinKeys = 'muezzinFajr';
  static Future<String?> getMuezzin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_muezzinKeys);
  }

  static Future<void> setMuezzin(String muezzin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_muezzinKeys, muezzin);
  }
}