import 'package:perfectplate/data/data_provider/cache_map_provider.dart';

class CacheMapRepository {

  static const String _userIsLoggedKey = 'user_is_logged';
  CacheMapProvider provider = CacheMapProvider();

  Future<void> init() async {
    await provider.instanciate();
  }

  bool? isUserLogged() {
    return provider.getBoolValue(_userIsLoggedKey);
  }

  Future<void> userLogged() async {
    await provider.setBoolValue(_userIsLoggedKey, true);
  }

  Future<void> userLogout() async {
    await provider.setBoolValue(_userIsLoggedKey, false);
  }

}