class RegisterDto {
  final String nombres;
  final String apellidos;
  final String email;
  final String password;
  final int? edad;
  final int rol; // Asumimos que envías el ID del rol (ej: 1 = Turista)

  RegisterDto({
    required this.nombres,
    required this.apellidos,
    required this.email,
    required this.password,
    this.edad,
    this.rol = 1, // Valor por defecto (ajusta según tu enum en .NET)
  });

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
      'password': password,
      'edad': edad,
      'rol': rol,
    };
  }
}