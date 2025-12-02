class LoginDto {
  final String email;
  final String password;

  LoginDto({
    required this.email,
    required this.password,
  });

  // Convertir a JSON para enviarlo a la API
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}