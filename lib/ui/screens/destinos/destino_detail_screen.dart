import 'package:flutter/material.dart';
import '../../../models/destino/destino.dart';

class DestinoDetailScreen extends StatelessWidget {
  final Destino destino;

  const DestinoDetailScreen({super.key, required this.destino});

  // --- TUS COLORES ---
  static const Color primaryColor = Color(0xFF5B2273);
  static const Color secondaryColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: CustomScrollView(
        slivers: [
          // --- 1. APPBAR ELÁSTICO (Con la imagen) ---
          SliverAppBar(
            expandedHeight: 400, // Altura de la imagen al inicio
            pinned: true, // La barra se queda fija arriba al bajar
            backgroundColor: primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                destino.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen con animación Hero (la que viene volando desde la tarjeta)
                  Hero(
                    tag: 'destino-${destino.idDestino}', 
                    child: Image.network(
                      destino.urlFotoPrincipal ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                  // Degradado para que el texto del título se lea bien
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                        stops: [0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 2. CONTENIDO DEL DETALLE ---
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: secondaryColor,
                // Bordes redondeados superiores para efecto de "hoja superpuesta"
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado: Tipo y Calificación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (destino.tipo != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: primaryColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            destino.tipo!.toUpperCase(),
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 28),
                          const SizedBox(width: 4),
                          Text(
                            destino.puntuacionMedia != null 
                                ? destino.puntuacionMedia.toString() 
                                : 'N/A',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Título grande
                  Text(
                    destino.nombre,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Ubicación (Icono y coordenadas o dirección)
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        // Aquí podrías poner una dirección real si la tuvieras en el modelo
                        'Lat: ${destino.latitud.toStringAsFixed(3)}, Lon: ${destino.longitud.toStringAsFixed(3)}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Descripción
                  const Text(
                    'Sobre este lugar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    destino.descripcionBreve,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Barra de acción inferior (Precio y Botón)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Entrada',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              destino.costoEntrada != null 
                                  ? '\$${destino.costoEntrada}' 
                                  : 'Gratis',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Acción futura: Reservar o Agendar
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                            shadowColor: primaryColor.withOpacity(0.4),
                          ),
                          child: const Text('Visitar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 50), // Espacio final
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}