import '../core/api/api_client.dart';
import '../models/destino/destino.dart';

class DestinoService {
  final ApiClient _apiClient = ApiClient();

  // Obtener todos los destinos
  Future<List<Destino>> getAll() async {
    try {
      // Tu endpoint en .NET es 'api/Destinos'
      // El ApiClient ya tiene la base URL, así que solo pasamos 'Destinos'
      final response = await _apiClient.get('Destinos');

      // Convertimos la lista JSON a lista de objetos Destino
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Destino.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Aquí podrás agregar métodos para Crear, Editar o Ver Detalle más adelante
}