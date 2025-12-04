import 'package:flutter/material.dart';

class HistorialPagosScreen extends StatelessWidget {
  const HistorialPagosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pagos = [
      {
        "servicio": "Spinning",
        "fecha": "2025-01-15",
        "valor": "\$80.000",
      },
      {
        "servicio": "Gym Libre",
        "fecha": "2025-01-10",
        "valor": "\$110.000",
      },
      {
        "servicio": "Pilates",
        "fecha": "2024-12-18",
        "valor": "\$90.000",
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Pagos"),
        backgroundColor: const Color(0xFF34B5A0),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: pagos.length,
        itemBuilder: (context, index) {
          final pago = pagos[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pago["servicio"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      "Fecha: ${pago["fecha"]}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  pago["valor"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
