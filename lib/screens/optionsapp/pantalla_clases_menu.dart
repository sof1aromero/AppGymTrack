import 'package:flutter/material.dart';
import 'package:gymtrack/screens/screensclass/pantalla_historialclases.dart';
import '../screensclass/pantalla_agendarclase.dart';

class PantallaClasesMenu extends StatelessWidget {
  final VoidCallback? onClose;

  const PantallaClasesMenu({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    final VoidCallback closeAction = onClose ?? () => Navigator.pop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clases",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: closeAction,
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

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    (MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom)
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  _buildClassItem(
                    title: "Agendar nueva clase",
                    description: "Reserva una clase disponible según tu horario de preferencia.",
                    buttonText: "Agendar",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaAgendarClase(
                            onVolverAClases: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildClassItem(
                    title: "Ver mis clases",
                    description: "Consulta las clases que ya tienes reservadas.",
                    buttonText: "Ver clases",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaMisClases(
                            onVolverAClases: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildClassItem(
                    title: "Ver historial",
                    description: "Mira las clases que ya tomaste o cancelaste.",
                    buttonText: "Ver historial",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaHistorial(
                                  onVolverAClases: () => Navigator.pop(context),
                              ),
                          ),
                      );
                    },
                  ),

                  const Spacer(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClassItem({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34B5A0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
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
}

class PantallaMisClases extends StatelessWidget {
  final VoidCallback onVolverAClases;

  const PantallaMisClases({super.key, required this.onVolverAClases});

  void _showCancelConfirmationDialog(BuildContext context, ClaseReservada clase) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Confirmar Cancelación",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
          content: Text(
            "¿Estás seguro de que deseas cancelar tu clase de ${clase.clase.nombre} el ${clase.fecha} a las ${clase.horaReservada}?",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                "No, mantener clase",
                style: TextStyle(color: Color(0xFF34B5A0), fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                print("Clase ${clase.clase.nombre} cancelada.");

                Navigator.of(dialogContext).pop();

              },
              child: const Text(
                "Sí, Cancelar",
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<ClaseReservada> misClases = [
      ClaseReservada(
        clase: ClaseDetalle(
          nombre: "Spinning",
          instructor: "Ana López",
          duracion: "45 minutos",
          hora: "09:00 a.m.",
          cuposDisponibles: 10,
          colorPrincipal: const Color(0xFF34B5A0),
        ),
        fecha: "10 de junio de 2025",
        horaReservada: "9:00 a.m.",
        estado: "Próximo",
      ),
      ClaseReservada(
        clase: ClaseDetalle(
          nombre: "Yoga Flow",
          instructor: "Sara Pérez",
          duracion: "60 minutos",
          hora: "10:00 a.m.",
          cuposDisponibles: 5,
          colorPrincipal: const Color(0xFF1ABC9C),
        ),
        fecha: "11 de junio de 2025",
        horaReservada: "10:00 a.m.",
        estado: "Próximo",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis clases reservadas"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 5,
                  ),
                  child: const Text("Volver a Clases", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: clase.colorPrincipal,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clase.nombre,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                    ),
                    const Divider(height: 25),
                    _buildInfoRow("Fecha:", claseReservada.fecha),
                    _buildInfoRow("Hora:", claseReservada.horaReservada),
                    _buildInfoRow("Instructor:", clase.instructor),
                    _buildInfoRow("Estado:", claseReservada.estado, isProximo ? clase.colorPrincipal : Colors.red),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF34B5A0), side: const BorderSide(color: Color(0xFF34B5A0), width: 1.5), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: const Text("Ver detalles", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        if (isProximo)
                          OutlinedButton(
                            onPressed: () {
                              _showCancelConfirmationDialog(context, claseReservada);
                            },
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.redAccent, side: const BorderSide(color: Colors.redAccent, width: 1.5), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text("Cancelar clase", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
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