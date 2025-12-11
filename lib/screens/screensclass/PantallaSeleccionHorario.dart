import 'package:flutter/material.dart';

// Definición de la estructura de datos para una clase
class ClaseDetalle {
  final String nombre;
  final String instructor;
  final String duracion;
  final String hora;
  final int cuposDisponibles;
  final Color colorPrincipal;

  ClaseDetalle({
    required this.nombre,
    required this.instructor,
    required this.duracion,
    required this.hora,
    required this.cuposDisponibles,
    required this.colorPrincipal,
  });
}

// Definición de la estructura de datos para los horarios
class HorarioDetalle {
  final String hora;
  final bool tieneCupo;

  HorarioDetalle({required this.hora, required this.tieneCupo});
}

// ============== PANTALLA PRINCIPAL ==============
class PantallaAgendarClase extends StatelessWidget {
  final VoidCallback onVolverAClases;

  const PantallaAgendarClase({super.key, required this.onVolverAClases});

  @override
  Widget build(BuildContext context) {
    final List<ClaseDetalle> clasesDelDia = [
      ClaseDetalle(
        nombre: "Spinning Intenso",
        instructor: "Ana López",
        duracion: "45 minutos",
        hora: "07:00 AM",
        cuposDisponibles: 10,
        colorPrincipal: const Color(0xFF34B5A0),
      ),
      ClaseDetalle(
        nombre: "Yoga Flow",
        instructor: "Sara Pérez",
        duracion: "60 minutos",
        hora: "10:00 AM",
        cuposDisponibles: 0,
        colorPrincipal: const Color(0xFF1ABC9C),
      ),
      ClaseDetalle(
        nombre: "Entrenamiento Funcional",
        instructor: "David Rojas",
        duracion: "45 minutos",
        hora: "05:30 PM",
        cuposDisponibles: 5,
        colorPrincipal: const Color(0xFF34B5A0),
      ),
      ClaseDetalle(
        nombre: "Pilates de suelo",
        instructor: "Laura Monsalve",
        duracion: "50 minutos",
        hora: "06:30 PM",
        cuposDisponibles: 20,
        colorPrincipal: const Color(0xFF1ABC9C),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agendar nueva clase",
          style: TextStyle(
            fontSize: 24,
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
          onPressed: onVolverAClases,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
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
            _buildDaySelector(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    ...clasesDelDia.map((clase) => _buildClassCard(context, clase)).toList(),
                    const SizedBox(height: 20),
                    _buildBackButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el modal de selección de horario
  void _showScheduleModal(BuildContext context, ClaseDetalle clase) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Usamos el widget interno definido abajo
      builder: (context) => _ModalSeleccionHorario(clase: clase),
    );
  }


  Widget _buildDaySelector() {
    final List<String> dias = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"];
    const int diaSeleccionado = 2;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white.withOpacity(0.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dias.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == diaSeleccionado;
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 20 : 8, right: 8),
            child: ChoiceChip(
              label: Text(dias[index]),
              selected: isSelected,
              onSelected: (selected) {
                print("Día seleccionado: ${dias[index]}");
              },
              selectedColor: const Color(0xFF34B5A0),
              backgroundColor: Colors.white.withOpacity(0.8),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              elevation: isSelected ? 3 : 1,
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, ClaseDetalle clase) {
    final bool isFull = clase.cuposDisponibles <= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                clase.nombre,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isFull ? Colors.black54 : const Color(0xFF2C3E50),
                ),
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: isFull ? Colors.redAccent : clase.colorPrincipal,
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text("Instructor: ${clase.instructor}", style: const TextStyle(fontSize: 15, color: Colors.black87)),
          const SizedBox(height: 15),

          _buildInfoRow(Icons.timer_outlined, "Duración:", clase.duracion, isFull),
          const SizedBox(height: 5),
          _buildInfoRow(Icons.schedule, "Hora:", clase.hora, isFull),
          const SizedBox(height: 5),
          _buildInfoRow(Icons.people_alt_outlined, "Cupos:", isFull ? "LLENO" : "${clase.cuposDisponibles} disponibles", isFull),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isFull ? null : () {
                _showScheduleModal(context, clase);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: clase.colorPrincipal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                disabledBackgroundColor: Colors.grey.shade400,
              ),
              child: Text(
                isFull ? "Lista de espera" : "Agendar Clase",
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

  Widget _buildInfoRow(IconData icon, String label, String value, bool isFull) {
    return Row(
      children: [
        Icon(icon, size: 18, color: isFull ? Colors.grey : const Color(0xFF2C3E50)),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isFull ? Colors.grey : Colors.black87,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            color: isFull ? Colors.grey : const Color(0xFF2C3E50),
            fontWeight: isFull ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onVolverAClases,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1ABC9C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
        ),
        child: const Text(
          "Volver a Clases",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


// ============== MODAL DE SELECCIÓN DE HORARIO (Integrado) ==============

class _ModalSeleccionHorario extends StatefulWidget {
  final ClaseDetalle clase;

  const _ModalSeleccionHorario({required this.clase});

  @override
  State<_ModalSeleccionHorario> createState() => __ModalSeleccionHorarioState();
}

class __ModalSeleccionHorarioState extends State<_ModalSeleccionHorario> {
  int _selectedDayIndex = 0; // 0: Hoy, 1: Mañana
  String? _selectedTime;

  final List<HorarioDetalle> horariosHoy = [
    HorarioDetalle(hora: "9:00 a.m.", tieneCupo: true),
    HorarioDetalle(hora: "10:00 a.m.", tieneCupo: false),
    HorarioDetalle(hora: "11:00 a.m.", tieneCupo: true),
    HorarioDetalle(hora: "12:00 p.m.", tieneCupo: true),
    HorarioDetalle(hora: "1:00 p.m.", tieneCupo: false),
  ];

  final List<HorarioDetalle> horariosManana = [
    HorarioDetalle(hora: "8:00 a.m.", tieneCupo: true),
    HorarioDetalle(hora: "9:30 a.m.", tieneCupo: true),
    HorarioDetalle(hora: "5:00 p.m.", tieneCupo: false),
    HorarioDetalle(hora: "7:00 p.m.", tieneCupo: true),
  ];

  // 🚀 FUNCIÓN COMPLETA DE CLASE RESERVADA + NAVEGACIÓN
  void _showReservationSuccessDialog(BuildContext context, String claseNombre, String hora) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: const Color(0xFF34B5A0), size: 30),
              const SizedBox(width: 10),
              const Text(
                "¡Clase Reservada!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          content: Text(
            "Has agendado con éxito '$claseNombre' a las $hora.\n¡Ya puedes verla en Mis Clases!",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 1. Cierra el AlertDialog
                Navigator.of(dialogContext).pop();

                // 2. Navega al inicio (Simulando ir a la pestaña 'Mis Clases')
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                "Ver Mis Clases",
                style: TextStyle(
                  color: Color(0xFF34B5A0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 💡 Función auxiliar para obtener el nombre del mes
  String getMonthName(int month) {
    switch (month) {
      case 1: return "Enero";
      case 2: return "Febrero";
      case 3: return "Marzo";
      case 4: return "Abril";
      case 5: return "Mayo";
      case 6: return "Junio";
      case 7: return "Julio";
      case 8: return "Agosto";
      case 9: return "Septiembre";
      case 10: return "Octubre";
      case 11: return "Noviembre";
      case 12: return "Diciembre";
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final todayDate = DateTime.now();
    final tomorrowDate = todayDate.add(const Duration(days: 1));
    String today = "Hoy (${todayDate.day} ${getMonthName(todayDate.month)})";
    String tomorrow = "Mañana (${tomorrowDate.day} ${getMonthName(tomorrowDate.month)})";

    final List<HorarioDetalle> currentHorarios =
    _selectedDayIndex == 0 ? horariosHoy : horariosManana;

    final bool canReserve = _selectedTime != null && currentHorarios.firstWhere((h) => h.hora == _selectedTime, orElse: () => HorarioDetalle(hora: "", tieneCupo: false)).tieneCupo;


    return Container(
      height: screenHeight * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selecciona un horario - ${widget.clase.nombre}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 15),

                Row(
                  children: [
                    _buildDayButton(label: today, index: 0),
                    const SizedBox(width: 10),
                    _buildDayButton(label: tomorrow, index: 1),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ...currentHorarios.map((horario) => _buildTimeButton(horario)).toList(),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: canReserve
                          ? () {
                        print("Reservando clase ${widget.clase.nombre} a las $_selectedTime");

                        // 1. Cierra el modal de horarios
                        Navigator.pop(context);

                        // 2. Muestra el AlertDialog de confirmación y maneja la navegación
                        _showReservationSuccessDialog(
                          context,
                          widget.clase.nombre,
                          _selectedTime!,
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34B5A0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: const Text(
                        "Reservar clase",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton({required String label, required int index}) {
    final bool isSelected = _selectedDayIndex == index;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedDayIndex = index;
            _selectedTime = null;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey.shade200 : Colors.white,
          foregroundColor: Colors.black87,
          side: const BorderSide(color: Colors.black26),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildTimeButton(HorarioDetalle horario) {
    final bool isSelected = _selectedTime == horario.hora;
    final bool isFull = !horario.tieneCupo;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        onPressed: isFull
            ? null
            : () {
          setState(() {
            _selectedTime = horario.hora;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF34B5A0) : Colors.white,
          foregroundColor: isSelected ? Colors.white : (isFull ? Colors.cyan.shade100 : const Color(0xFF34B5A0)),
          side: BorderSide(
            color: isSelected ? const Color(0xFF34B5A0) : (isFull ? Colors.cyan.shade100 : const Color(0xFF34B5A0)),
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          horario.tieneCupo ? horario.hora : "${horario.hora} (Sin cupo)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : (isFull ? Colors.grey : const Color(0xFF34B5A0)),
          ),
        ),
      ),
    );
  }
}