class Destino {
  final int idDestino;
  final String nombre;
  final String descripcionBreve;
  final String? tipo;
  final double latitud;
  final double longitud;
  final double? costoEntrada;
  final String? urlFotoPrincipal;
  final double? puntuacionMedia;

  Destino({
    required this.idDestino,
    required this.nombre,
    required this.descripcionBreve,
    this.tipo,
    required this.latitud,
    required this.longitud,
    this.costoEntrada,
    this.urlFotoPrincipal,
    this.puntuacionMedia,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    return Destino(
      idDestino: json['idDestino'],
      nombre: json['nombre'],
      descripcionBreve: json['descripcionBreve'],
      tipo: json['tipo'],
      // Parseo seguro de números (API .NET a veces manda enteros o doubles)
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      costoEntrada: json['costoEntrada'] != null 
          ? (json['costoEntrada'] as num).toDouble() 
          : null,
      urlFotoPrincipal: json['urlFotoPrincipal'],
      puntuacionMedia: json['puntuacionMedia'] != null 
          ? (json['puntuacionMedia'] as num).toDouble() 
          : null,
    );
  }
}