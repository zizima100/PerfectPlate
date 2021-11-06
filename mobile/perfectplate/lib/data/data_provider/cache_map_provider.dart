import 'package:shared_preferences/shared_preferences.dart';

class CacheMapProvider {
  SharedPreferences? _preferences;
  
  Future<void> instanciate() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool? getBoolValue(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }
}