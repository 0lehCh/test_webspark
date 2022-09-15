import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFacade {
  final SharedPreferences _storage;

  SharedPreferencesFacade(this._storage);

  String get(String key) {
    final name = _storage.getString(key.toString());
    return name.toString();
  }

  void set(String key, String value) {
    _storage.setString(key.toString(), value);
  }

  void cleanAll() {
    _storage.clear();
  }
}