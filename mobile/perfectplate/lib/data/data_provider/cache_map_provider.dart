import 'package:shared_preferences/shared_preferences.dart';

class CacheMapProvider {
  SharedPreferences? _preferences;
  
  Future<void> instanciate() async {
    _preferences = await SharedPreferences.getInstance();
  }

  int? getIntValue(String key) {
    print('getting $key');
    print('_preferences?.getInt(key) = ${_preferences?.getInt(key)}');
    return _preferences?.getInt(key);
  }

  Future<void> setIntValue(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }
}