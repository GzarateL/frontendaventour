import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Claves para guardar datos
  static const String _tokenKey = 'token';
  static const String _userKey = 'user_data';

  // Guardar Token
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Obtener Token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Borrar todo (Logout)
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}