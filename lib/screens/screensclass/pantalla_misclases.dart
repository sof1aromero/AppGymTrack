import 'package:flutter/material.dart';
import 'pantalla_agendarclase.dart'; // Importa ClaseDetalle

// Definición de una clase simulada para las clases reservadas
// Usamos ClaseDetalle, pero le agregamos el campo 'estado'
class ClaseReservada {
  final ClaseDetalle clase;
  final String fecha;
  final String horaReservada;
  final String estado; // Ejemplo: 'Próximo', 'Cancelado', 'Completado'

  ClaseReservada({
    required this.clase,
    required this.fecha,
    required this.horaReservada,
    required this.estado,
  });
}

class PantallaMisClases extends StatelessWidget {
  final VoidCallback onVolverAClases;

  const PantallaMisClases({super.key, required this.onVolverAClases});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo simulados para las clases reservadas
    final List<ClaseReservada> misClases = [
      ClaseReservada(
        clase: ClaseDetalle(
          nombre: "Spinning",
          instructor: "Ana López",
          duracion: "45 minutos",
          hora: "09:00 a.m.", // Hora original de la clase
          cuposDisponibles: 10,
          colorPrincipal: const Color(0xFF34B5A0),
        ),
        fecha: "10 de junio de 2025",
        horaReservada: "9:00 a.m.",
        estado: "Próximo",
      ),
      ClaseReservada(
        clase: ClaseDetalle(
          nombre: "Pilates Avanzado",
          instructor: "Laura V.",
          duracion: "50 minutos",
          hora: "06:00 p.m.",
          cuposDisponibles: 5,
          colorPrincipal: const Color(0xFF1ABC9C),
        ),
        fecha: "12 de junio de 2025",
        horaReservada: "6:00 p.m.",
        estado: "Próximo",
      ),
      // Puedes agregar más clases aquí si lo deseas
    ];

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
            Navigator.of(context).pop(); // Vuelve a la pantalla anterior
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: misClases.map((clase) => _buildReservedClassCard(context, clase)).toList(),
                ),
              ),
            ),

            // Botón de Volver a Clases (sección inferior)
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0, top: 20.0),
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
                    // Estilo de sombra para coincidir con la imagen
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

  Widget _buildReservedClassCard(BuildContext context, ClaseReservada claseReservada) {
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
          _buildInfoRow("Estado:", claseReservada.estado, isProximo ? clase.colorPrincipal : Colors.red),

          const SizedBox(height: 20),

          // Fila de botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Botón "Ver detalles"
              OutlinedButton(
                onPressed: () {
                  print("Ver detalles de ${clase.nombre}");
                  // Aquí iría la navegación a la pantalla de detalles
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF34B5A0),
                  side: const BorderSide(color: Color(0xFF34B5A0), width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Ver detalles", style: TextStyle(fontWeight: FontWeight.bold)),
              ),

              // Botón "Cancelar clase" (o texto si no es próxima)
              if (isProximo)
                OutlinedButton(
                  onPressed: () {
                    print("Cancelar clase ${clase.nombre}");
                    // Lógica de cancelación
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Cancelar clase", style: TextStyle(fontWeight: FontWeight.bold)),
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
            width: 100, // Ancho fijo para las etiquetas
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