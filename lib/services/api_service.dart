import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import '../models/clase_model.dart';
import '../models/usuario_model.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:3000';


  Future<Usuario> iniciarSesion(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['token'];

        return Usuario.fromJson(data['usuario']);

      } else if (response.statusCode == 401) {
        throw Exception('Credenciales incorrectas. Verifique usuario y contraseña.');
      } else {
        throw Exception('Error en el servidor: ${response.body}');
      }
    } catch (e) {
      throw Exception('No se pudo conectar al servidor. Verifique su conexión y la URL: $e');
    }
  }

  Future<void> registrarUsuario(Map<String, dynamic> datosRegistro) async {
    final url = Uri.parse('$_baseUrl/api/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datosRegistro),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['mensaje'] ?? 'Fallo en el registro.');
    }
  }

  Future<void> solicitarCodigoRecuperacion(String email) async {
    final url = Uri.parse('$_baseUrl/api/auth/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al solicitar código.');
    }
  }

  Future<void> restablecerContrasena(String email, String code, String newPassword) async {
    final url = Uri.parse('$_baseUrl/api/auth/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'codigo': code, 'password': newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al restablecer contraseña.');
    }
  }


  Future<List<ClaseReservada>> getMisClasesReservadas(String token) async {
    final url = Uri.parse('$_baseUrl/api/clases/reservadas');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ClaseReservada.fromJson(json)).toList();
    } else {
      throw Exception('Fallo al cargar las clases reservadas.');
    }
  }
}