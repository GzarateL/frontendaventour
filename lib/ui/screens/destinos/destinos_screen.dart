import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/destinos_provider.dart';
import '../../widgets/destino_card.dart';

class DestinosScreen extends StatefulWidget {
  const DestinosScreen({super.key});

  @override
  State<DestinosScreen> createState() => _DestinosScreenState();
}

class _DestinosScreenState extends State<DestinosScreen> {
  @override
  void initState() {
    super.initState();
    // Cargamos los destinos apenas se construye la pantalla
    // Usamos addPostFrameCallback para asegurar que el contexto esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinosProvider>(context, listen: false).loadDestinos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final destinosProvider = Provider.of<DestinosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar Destinos'),
      ),
      body: destinosProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : destinosProvider.errorMessage != null
              ? Center(child: Text('Error: ${destinosProvider.errorMessage}'))
              : RefreshIndicator(
                  onRefresh: () => destinosProvider.loadDestinos(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: destinosProvider.destinos.length,
                    itemBuilder: (context, index) {
                      final destino = destinosProvider.destinos[index];
                      return DestinoCard(destino: destino);
                    },
                  ),
                ),
    );
  }
}