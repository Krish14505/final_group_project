import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static Future<void> saveLastAirplane(
      String type, int passengers, int speed, int range) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_type', type);
    prefs.setInt('last_passengers', passengers);
    prefs.setInt('last_speed', speed);
    prefs.setInt('last_range', range);
  }

  static Future<Map<String, dynamic>> getLastAirplane() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'type': prefs.getString('last_type') ?? '',
      'passengers': prefs.getInt('last_passengers') ?? 0,
      'speed': prefs.getInt('last_speed') ?? 0,
      'range': prefs.getInt('last_range') ?? 0,
    };
  }
}
