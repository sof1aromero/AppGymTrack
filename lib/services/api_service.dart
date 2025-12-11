import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/clase_model.dart';

class ApiService {
  final String baseUrl = 'https://tu-dominio-aqui.com/api';

  Future<List<ClaseReservada>> getMisClasesReservadas(String token) async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/clases_mock.json',
      );

      List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList
          .map((json) => ClaseReservada.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Fallo al cargar las clases (Mocking Error): $e');
    }
  }
}
