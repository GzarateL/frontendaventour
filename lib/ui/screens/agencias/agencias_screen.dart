import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/agencias_provider.dart';
import '../../widgets/agencia_card.dart';

class AgenciasScreen extends StatefulWidget {
  const AgenciasScreen({super.key});

  @override
  State<AgenciasScreen> createState() => _AgenciasScreenState();
}

class _AgenciasScreenState extends State<AgenciasScreen> {
  // Tus colores
  static const Color primaryColor = Color(0xFF5B2273);
  static const Color secondaryColor = Color(0xFFF2F2F2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgenciasProvider>(context, listen: false).loadAgencias();
    });
  }

  @override
  Widget build(BuildContext context) {
    final agenciasProvider = Provider.of<AgenciasProvider>(context);

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: const Text('Agencias y Guías', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
        actions: [
          // Botón de filtro simple
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: primaryColor),
            onSelected: (value) {
              agenciasProvider.loadAgencias(tipo: value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Todos', child: Text('Ver Todos')),
              const PopupMenuItem(value: 'Agencia', child: Text('Solo Agencias')),
              const PopupMenuItem(value: 'Guia', child: Text('Solo Guías')),
            ],
          ),
        ],
      ),
      body: agenciasProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : agenciasProvider.errorMessage != null
              ? Center(child: Text('Error: ${agenciasProvider.errorMessage}'))
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: agenciasProvider.agencias.length,
                  itemBuilder: (context, index) {
                    return AgenciaCard(agencia: agenciasProvider.agencias[index]);
                  },
                ),
    );
  }
}