class Usuario {
  final int id;
  final String nombreCompleto;
  final String email;
  final String token;

  Usuario({
    required this.id,
    required this.nombreCompleto,
    required this.email,
    required this.token,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final String token = (json['token'] as String?) ?? '';
    final usuarioData = json['usuario'] as Map<String, dynamic>? ?? {};

    return Usuario(
      id: usuarioData['id'] as int? ?? 0,
      nombreCompleto: (usuarioData['nombreCompleto'] as String?) ?? '',
      email: (usuarioData['email'] as String?) ?? '',
      token: token,
    );
  }
}