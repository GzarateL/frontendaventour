import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/agencia/agencia.dart';

class AgenciaCard extends StatelessWidget {
  final Agencia agencia;

  const AgenciaCard({super.key, required this.agencia});

  // Función para abrir WhatsApp
  Future<void> _launchWhatsApp() async {
    final url = Uri.parse('https://wa.me/${agencia.whatsappContacto}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Manejo de error simple si no puede abrir
      debugPrint('No se pudo abrir WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definimos colores locales o usamos los del tema
    const primaryColor = Color(0xFF5B2273);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nombre y Verificado
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          agencia.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (agencia.validado == true) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.verified, color: Colors.blue, size: 20),
                      ],
                    ],
                  ),
                ),
                // Puntuación
                if (agencia.puntuacionMedia != null)
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
                          agencia.puntuacionMedia.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Tipo (Agencia/Guía)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                agencia.tipo.toUpperCase(),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade800),
              ),
            ),
            const SizedBox(height: 12),
            // Descripción
            if (agencia.descripcion != null)
              Text(
                agencia.descripcion!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            const SizedBox(height: 16),
            // Botón de Contacto
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _launchWhatsApp,
                icon: const Icon(Icons.message, size: 18, color: Colors.green),
                label: const Text('Contactar por WhatsApp', style: TextStyle(color: Colors.green)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}