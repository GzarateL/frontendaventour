import 'package:aventour_frontend/providers/agencias_provider.dart';
import 'package:aventour_frontend/providers/destinos_provider.dart';
import 'package:aventour_frontend/ui/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/home/home_screen.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DestinosProvider()),
        ChangeNotifierProvider(create: (_) => AgenciasProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aventour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Este widget decide qué pantalla mostrar según el estado
      home: const AuthCheckWrapper(),
    );
  }
}

// Widget wrapper que escucha cambios en la sesión
class AuthCheckWrapper extends StatelessWidget {
  const AuthCheckWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado de autenticación
    final authStatus = context.select((AuthProvider p) => p.authStatus);

    if (authStatus == AuthStatus.checking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authStatus == AuthStatus.authenticated) {
      return const HomeScreen();
    }

    // CAMBIO AQUÍ: En lugar de LoginScreen, mostramos WelcomeScreen
    return const WelcomeScreen(); 
  }
}