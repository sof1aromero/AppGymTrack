import 'package:flutter/material.dart';

class HistorialClasesScreen extends StatelessWidget {
  const HistorialClasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> clases = [
      {
        "clase": "Spinning - Intensivo",
        "fecha": "2025-01-20",
        "estado": "Asistida",
      },
      {
        "clase": "Pilates",
        "fecha": "2025-01-18",
        "estado": "Cancelada",
      },
      {
        "clase": "Funcional",
        "fecha": "2025-01-17",
        "estado": "Asistida",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Clases"),
        backgroundColor: const Color(0xFF34B5A0),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: clases.length,
        itemBuilder: (context, index) {
          final clase = clases[index];
          final bool asistida = clase["estado"] == "Asistida";

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
                      clase["clase"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      "Fecha: ${clase["fecha"]}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  clase["estado"]!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: asistida ? Colors.green : Colors.red,
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
