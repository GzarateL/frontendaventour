import '../core/api/api_client.dart';
import '../models/agencia/agencia.dart';

class AgenciaService {
  final ApiClient _apiClient = ApiClient();

  // Endpoint: api/v1/Agencias
  // El ApiClient ya tiene la base 'api/', así que agregamos 'v1/Agencias'
  Future<List<Agencia>> getAll({String? tipo}) async {
    try {
      String endpoint = 'v1/Agencias';
      if (tipo != null && tipo != 'Todos') {
        endpoint += '?tipo=$tipo';
      }

      final response = await _apiClient.get(endpoint);
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Agencia.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}