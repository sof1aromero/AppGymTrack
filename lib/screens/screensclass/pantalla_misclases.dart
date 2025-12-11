import 'package:flutter/material.dart';

import '../../models/clase_model.dart';
import '../../services/api_service.dart';

class PantallaMisClases extends StatelessWidget {
  final VoidCallback onVolverAClases;

  final ApiService apiService = ApiService();
  final String dummyToken = "TOKEN_DE_USUARIO_DEMO";

  PantallaMisClases({super.key, required this.onVolverAClases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis clases reservadas",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6EE), Color(0xFF34B5A0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ClaseReservada>>(
                future: apiService.getMisClasesReservadas(dummyToken),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error al cargar datos: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final List<ClaseReservada> misClases = snapshot.data!;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: misClases
                            .map(
                              (clase) =>
                                  _buildReservedClassCard(context, clase),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No tienes clases reservadas."),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 40.0,
                top: 20.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onVolverAClases,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34B5A0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF34B5A0).withOpacity(0.5),
                  ),
                  child: const Text(
                    "Volver a Clases",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservedClassCard(
    BuildContext context,
    ClaseReservada claseReservada,
  ) {
    final ClaseDetalle clase = claseReservada.clase;
    final bool isProximo = claseReservada.estado == 'Próximo';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clase.nombre,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const Divider(height: 25),

          _buildInfoRow("Fecha:", claseReservada.fecha),
          _buildInfoRow("Hora:", claseReservada.horaReservada),
          _buildInfoRow("Instructor:", clase.instructor),
          _buildInfoRow(
            "Estado:",
            claseReservada.estado,
            isProximo ? clase.colorPrincipal : Colors.red,
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  print("Ver detalles de ${clase.nombre}");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF34B5A0),
                  side: const BorderSide(color: Color(0xFF34B5A0), width: 1.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Ver detalles",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              if (isProximo)
                OutlinedButton(
                  onPressed: () {
                    print("Cancelar clase ${clase.nombre}");
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancelar clase",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: valueColor ?? const Color(0xFF2C3E50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
