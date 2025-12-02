class Agencia {
  final int idAgencia;
  final String nombre;
  final String tipo; // "Agencia" o "Guia"
  final String whatsappContacto;
  final String? email;
  final String? descripcion;
  final bool? validado;
  final double? puntuacionMedia;

  Agencia({
    required this.idAgencia,
    required this.nombre,
    required this.tipo,
    required this.whatsappContacto,
    this.email,
    this.descripcion,
    this.validado,
    this.puntuacionMedia,
  });

  factory Agencia.fromJson(Map<String, dynamic> json) {
    return Agencia(
      idAgencia: json['idAgencia'],
      nombre: json['nombre'],
      tipo: json['tipo'] ?? 'Agencia',
      whatsappContacto: json['whatsappContacto'],
      email: json['email'],
      descripcion: json['descripcion'],
      validado: json['validado'],
      puntuacionMedia: json['puntuacionMedia'] != null 
          ? (json['puntuacionMedia'] as num).toDouble() 
          : null,
    );
  }
}