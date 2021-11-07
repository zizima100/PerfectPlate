import 'package:perfectplate/data/data_provider/cache_map_provider.dart';

class CacheMapRepository {

  static const String _userIdKey = 'user_id';
  CacheMapProvider provider = CacheMapProvider();

  Future<void> init() async {
    await provider.instanciate();
  }

  int? retrieveUserIdCache() {
    return provider.getIntValue(_userIdKey);
  }

  Future<void> setUserId(int? id) async {
    if(id == null) {
      return;
    }
    await provider.setIntValue(_userIdKey, id);
  }

  Future<void> userLogout() async {
    await provider.remove(_userIdKey);
  }

}