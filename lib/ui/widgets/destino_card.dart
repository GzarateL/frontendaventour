import 'package:flutter/material.dart';
import '../../models/destino/destino.dart';
import '../screens/destinos/destino_detail_screen.dart'; // Importamos la pantalla de detalle

class DestinoCard extends StatelessWidget {
  final Destino destino;

  const DestinoCard({super.key, required this.destino});

  // Color morado de tu marca para usar en el botón
  static const Color primaryColor = Color(0xFF5B2273);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Bordes un poco más redondeados
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- IMAGEN DEL DESTINO CON EFECTO HERO ---
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Hero(
              // Este tag debe ser único y coincidir con el de la pantalla de detalle
              tag: 'destino-${destino.idDestino}', 
              child: destino.urlFotoPrincipal != null
                  ? Image.network(
                      destino.urlFotoPrincipal!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.landscape, size: 60, color: primaryColor),
                    ),
            ),
          ),
          
          // --- INFORMACIÓN ---
          Padding(
            padding: const EdgeInsets.all(16), // Un poco más de espacio interno
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        destino.nombre,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (destino.puntuacionMedia != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              destino.puntuacionMedia.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  destino.descripcionBreve,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16), // Más espacio antes de los botones
                
                // --- PRECIO Y BOTÓN VER MÁS ---
                Row(
                  children: [
                    if (destino.costoEntrada != null)
                      Text(
                        '\$${destino.costoEntrada}',
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w900, 
                          color: primaryColor // Precio en morado para destacar
                        ),
                      )
                    else
                      const Text(
                        'Gratis', 
                        style: TextStyle(
                          color: Colors.green, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                      ),
                    
                    const Spacer(),
                    
                    // Botón con estilo de la marca
                    FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(0.1), // Fondo morado suave
                        foregroundColor: primaryColor, // Texto morado fuerte
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        // Navegación a la pantalla de detalle
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DestinoDetailScreen(destino: destino),
                          ),
                        );
                      },
                      child: const Text('Ver más', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}