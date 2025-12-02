import 'package:flutter/material.dart';
import '../models/agencia/agencia.dart';
import '../services/agencia_service.dart';

class AgenciasProvider extends ChangeNotifier {
  final AgenciaService _agenciaService = AgenciaService();

  List<Agencia> _agencias = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Agencia> get agencias => _agencias;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAgencias({String? tipo}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _agencias = await _agenciaService.getAll(tipo: tipo);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}