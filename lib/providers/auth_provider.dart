import 'package:flutter/material.dart';
import '../models/auth/auth_response.dart';
import '../models/auth/login_dto.dart';
import '../models/auth/register_dto.dart';
import '../services/auth_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _authStatus = AuthStatus.checking;
  AuthResponse? _user; // Aquí guardamos los datos del usuario (Nombre, Rol, etc.)
  bool _isLoading = false;
  String? _errorMessage;

  // Getters para que la UI consuma los datos
  AuthStatus get authStatus => _authStatus;
  AuthResponse? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    checkAuthStatus();
  }

  // Verificar si ya hay sesión al abrir la app
  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    
    if (isLoggedIn) {
      // Aquí idealmente llamaríamos a un endpoint "GetProfile" para refrescar datos,
      // pero por ahora solo marcamos como autenticado si hay token.
      _authStatus = AuthStatus.authenticated;
      // TODO: Cargar datos del usuario desde Storage o API si es necesario
    } else {
      _authStatus = AuthStatus.notAuthenticated;
    }
    notifyListeners();
  }

  // LOGIN
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loginDto = LoginDto(email: email, password: password);
      final response = await _authService.login(loginDto);
      
      _user = response;
      _authStatus = AuthStatus.authenticated;
      _isLoading = false;
      notifyListeners();
      return true; // Login exitoso
    } catch (e) {
      _errorMessage = e.toString();
      _authStatus = AuthStatus.notAuthenticated;
      _isLoading = false;
      notifyListeners();
      return false; // Login fallido
    }
  }

  // REGISTRO
  Future<bool> register(String nombres, String apellidos, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final registerDto = RegisterDto(
        nombres: nombres,
        apellidos: apellidos,
        email: email,
        password: password,
        rol: 1, // Turista por defecto
      );
      
      final response = await _authService.register(registerDto);
      
      _user = response;
      _authStatus = AuthStatus.authenticated;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _authStatus = AuthStatus.notAuthenticated;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _authService.logout();
    _authStatus = AuthStatus.notAuthenticated;
    _user = null;
    notifyListeners();
  }
}