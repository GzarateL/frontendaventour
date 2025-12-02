import '../core/api/api_client.dart';
import '../models/auth/auth_response.dart';
import '../models/auth/login_dto.dart';
import '../models/auth/register_dto.dart';
import 'storage_service.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  // LOGIN
  Future<AuthResponse> login(LoginDto loginDto) async {
    try {
      // Llamada al endpoint de tu backend
      final response = await _apiClient.post(
        'Usuario/login', 
        body: loginDto.toJson(),
      );

      // Mapeamos la respuesta 'data' del backend a nuestro modelo
      final authResponse = AuthResponse.fromJson(response['data']);

      // Si trae token, lo guardamos automáticamente
      if (authResponse.token != null) {
        await _storageService.setToken(authResponse.token!);
      }

      return authResponse;
    } catch (e) {
      rethrow; // Pasamos el error al Provider/UI para que muestre la alerta
    }
  }

  // REGISTRO
  Future<AuthResponse> register(RegisterDto registerDto) async {
    try {
      final response = await _apiClient.post(
        'Usuario/registrar', 
        body: registerDto.toJson(),
      );

      // Asumiendo que tu backend devuelve el usuario creado en 'data'
      // Si el registro no loguea automáticamente, ajustaremos esto luego.
      return AuthResponse.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _storageService.clear();
  }
  
  // VERIFICAR ESTADO (Para saber si ya hay token al abrir la app)
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getToken();
    return token != null && token.isNotEmpty;
  }
}