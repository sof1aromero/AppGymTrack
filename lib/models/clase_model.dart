import 'package:flutter/material.dart';

Color colorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  return Color(int.parse(hexColor, radix: 16));
}

class ClaseDetalle {
  final String nombre;
  final String instructor;
  final String duracion;
  final String hora;
  final int cuposDisponibles;
  final Color colorPrincipal;

  const ClaseDetalle({
    required this.nombre,
    required this.instructor,
    required this.duracion,
    required this.hora,
    required this.cuposDisponibles,
    required this.colorPrincipal,
  });

  factory ClaseDetalle.fromJson(Map<String, dynamic> json) {
    return ClaseDetalle(
      nombre: json['nombre_clase'] as String,
      instructor: json['instructor'] as String,
      duracion: json['duracion'] as String,
      hora: json['hora_inicio'] as String,
      cuposDisponibles: json['cupos_disponibles'] as int,

      colorPrincipal: colorFromHex(json['color_hex'] as String),
    );
  }
}

class ClaseReservada {
  final ClaseDetalle clase;
  final String fecha;
  final String horaReservada;
  final String estado;

  ClaseReservada({
    required this.clase,
    required this.fecha,
    required this.horaReservada,
    required this.estado,
  });

  factory ClaseReservada.fromJson(Map<String, dynamic> json) {
    return ClaseReservada(
      fecha: json['fecha_reserva'] as String,
      horaReservada: json['hora_reservada'] as String,
      estado: json['estado_reserva'] as String,

      clase: ClaseDetalle.fromJson(
        json['detalle_clase'] as Map<String, dynamic>,
      ),
    );
  }
}
