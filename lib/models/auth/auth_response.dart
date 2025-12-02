class AuthResponse {
  final int idUsuario;
  final String nombres;
  final String apellidos;
  final String email;
  final bool esAdministrador;
  final String rol;
  final String? token; // Puede ser nulo si solo estás consultando el perfil, pero en login viene lleno

  AuthResponse({
    required this.idUsuario,
    required this.nombres,
    required this.apellidos,
    required this.email,
    required this.esAdministrador,
    required this.rol,
    this.token,
  });

  // Factory para crear una instancia desde el JSON que responde tu API
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      idUsuario: json['idUsuario'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      email: json['email'],
      esAdministrador: json['esAdministrador'] ?? false,
      rol: json['rol'] ?? 'Turista', // Valor por defecto si viene nulo
      token: json['token'],
    );
  }
  
  // Para guardar el usuario en SharedPreferences (como texto)
  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
      'esAdministrador': esAdministrador,
      'rol': rol,
      'token': token,
    };
  }
}