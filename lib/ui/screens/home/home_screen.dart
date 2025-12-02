import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Al cerrar sesión, el main.dart detectará el cambio y mostrará el Login
              authProvider.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Hola, ${user?.nombres ?? 'Viajero'}!', 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Rol: ${user?.rol ?? 'Invitado'}'),
            const SizedBox(height: 20),
            const Text('Aquí irán tus destinos turísticos...'),
          ],
        ),
      ),
    );
  }
}