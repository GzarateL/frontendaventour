import 'package:flutter/material.dart';
import '../models/destino/destino.dart';
import '../services/destino_service.dart';

class DestinosProvider extends ChangeNotifier {
  final DestinoService _destinoService = DestinoService();

  List<Destino> _destinos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Destino> get destinos => _destinos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Cargar destinos iniciales
  Future<void> loadDestinos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _destinos = await _destinoService.getAll();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}