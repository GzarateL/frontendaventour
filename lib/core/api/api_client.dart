import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants/environment.dart';
import '../errors/exceptions.dart';

class ApiClient {
  final http.Client _client = http.Client();
  final String _baseUrl = Environment.apiUrl;

  // Obtener headers con Token si existe
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // 'token' es la key que usaremos luego

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Método GET Genérico
  Future<dynamic> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('$_baseUrl/$endpoint');
      
      final response = await _client.get(uri, headers: headers).timeout(
        const Duration(seconds: 10),
      );

      return _processResponse(response);
    } on SocketException {
      throw NetworkException('No hay conexión a internet');
    } catch (e) {
      rethrow;
    }
  }

  // Método POST Genérico
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('$_baseUrl/$endpoint');

      final response = await _client
          .post(
            uri, 
            headers: headers, 
            body: body != null ? jsonEncode(body) : null
          )
          .timeout(const Duration(seconds: 10));

      return _processResponse(response);
    } on SocketException {
      throw NetworkException('No hay conexión a internet');
    } catch (e) {
      rethrow;
    }
  }

  // Método PUT Genérico
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('$_baseUrl/$endpoint');

      final response = await _client
          .put(
            uri, 
            headers: headers, 
            body: body != null ? jsonEncode(body) : null
          )
          .timeout(const Duration(seconds: 10));

      return _processResponse(response);
    } on SocketException {
      throw NetworkException('No hay conexión a internet');
    } catch (e) {
      rethrow;
    }
  }

  // Método DELETE Genérico
  Future<dynamic> delete(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('$_baseUrl/$endpoint');

      final response = await _client.delete(uri, headers: headers).timeout(
        const Duration(seconds: 10),
      );

      return _processResponse(response);
    } on SocketException {
      throw NetworkException('No hay conexión a internet');
    } catch (e) {
      rethrow;
    }
  }

  // Procesador de respuestas centralizado
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Si el body está vacío (ej. 204 No Content), retornamos null o map vacío
        if (response.body.isEmpty) return {};
        return jsonDecode(response.body);
      case 204:
        return {};
      case 400:
        throw ServerException(_extractErrorMessage(response.body));
      case 401:
      case 403:
        throw AuthException('No autorizado. Por favor inicia sesión nuevamente.');
      case 404:
        throw ServerException('Recurso no encontrado.');
      case 500:
      default:
        throw ServerException('Error del servidor: ${response.statusCode}');
    }
  }

  // Intenta sacar el mensaje de error que manda tu .NET ("error": "mensaje")
  String _extractErrorMessage(String body) {
    try {
      final Map<String, dynamic> data = jsonDecode(body);
      if (data.containsKey('error')) {
        return data['error'];
      }
      if (data.containsKey('mensaje')) {
        return data['mensaje'];
      }
      // Si .NET devuelve los errores de validación (ModelState)
      if (data.containsKey('errors')) {
        return data['errors'].toString();
      }
      return 'Error desconocido';
    } catch (_) {
      return body; // Si no es JSON, devuelve el texto crudo
    }
  }
}