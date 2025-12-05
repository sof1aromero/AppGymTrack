import 'package:flutter/material.dart';


class Notificacion {
  final String estado; 
  final String titulo;
  final String descripcion;
  final String tiempo; 
  final DateTime fecha; 

  Notificacion({
    required this.estado,
    required this.titulo,
    required this.descripcion,
    required this.tiempo,
    required this.fecha,
  });
}

class PantallaNotificaciones extends StatefulWidget {
  const PantallaNotificaciones({super.key});

  @override
  State<PantallaNotificaciones> createState() => _PantallaNotificacionesState();
}

class _PantallaNotificacionesState extends State<PantallaNotificaciones> {
  String _filtroSeleccionado = "Hoy";
  final List<String> _opcionesFiltro = [
    "Todas", 
    "Hoy",
    "Esta semana",
    "Este mes",
    "Este año"
  ];


  late final List<Notificacion> _todasLasNotificaciones;

  @override
  void initState() {
    super.initState();
 
    final now = DateTime.now();
    _todasLasNotificaciones = [
      Notificacion(
        estado: "No leída",
        titulo: "Tu pago se aproxima",
        descripcion: "El cobro de Spinning está programado para mañana.",
        tiempo: "Hace 3 horas", 
        fecha: now.subtract(const Duration(hours: 3)), 
      ),
      Notificacion(
        estado: "Leída",
        titulo: "Clase cancelada",
        descripcion: "La clase de Boxeo con Juan Pérez ha sido cancelada.",
        tiempo: "Hace 5 horas", 
        fecha: now.subtract(const Duration(hours: 5)), 
      ),
      Notificacion(
        estado: "Leída",
        titulo: "Recordatorio de clase",
        descripcion: "Tu clase de Yoga Suave comienza en 30 minutos.",
        tiempo: "Hace 1 día", 
        fecha: now.subtract(const Duration(days: 1, minutes: 1)), 
      ),
      Notificacion(
        estado: "No leída",
        titulo: "Pago vencido",
        descripcion: "Tu pago de membresía por \$150.000 venció ayer.",
        tiempo: "Hace 1 día",
        fecha: now.subtract(const Duration(days: 1, hours: 1)), 
      ),
      Notificacion(
        estado: "Leída",
        titulo: "Nueva oferta",
        descripcion: "¡Tenemos un 20% de descuento en masajes deportivos!",
        tiempo: "Hace 2 semanas", 
        fecha: now.subtract(const Duration(days: 14)), 
      ),
      Notificacion(
        estado: "No leída",
        titulo: "Actualización de horarios",
        descripcion: "Los horarios de la piscina han sido modificados.",
        tiempo: "Hace 3 meses",
        fecha: now.subtract(const Duration(days: 90)), 
      ),
    ];
  }

  
  List<Notificacion> _obtenerNotificacionesFiltradas() {
    
    if (_filtroSeleccionado == "Todas") {
      return _todasLasNotificaciones
          .toList()
          .cast<Notificacion>()
          ..sort((a, b) => b.fecha.compareTo(a.fecha));
    }


    final now = DateTime.now();

    final listaFiltrada = _todasLasNotificaciones.where((notificacion) {
      final notiDate = notificacion.fecha;

      switch (_filtroSeleccionado) {
        case "Hoy":
          return notiDate.year == now.year &&
              notiDate.month == now.month &&
              notiDate.day == now.day;
        case "Esta semana":
         
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          return notiDate.isAfter(startOfWeek.subtract(const Duration(seconds: 1)));
        case "Este mes":
          return notiDate.year == now.year &&
              notiDate.month == now.month;
        case "Este año":
          return notiDate.year == now.year;
        default:
          return false; 
      }
    }).toList();


    listaFiltrada.sort((a, b) => b.fecha.compareTo(a.fecha));

    return listaFiltrada;
  }

  @override
  Widget build(BuildContext context) {
    final notificacionesFiltradas = _obtenerNotificacionesFiltradas();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6EE), Color(0xFF34B5A0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 40),
                    child: Text(
                      "Notificaciones",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ),

                _buildFiltroDropdown(),

                const SizedBox(height: 20),

                Expanded(
                  child: notificacionesFiltradas.isEmpty
                      ? Center(
                          child: Text(
                            "No hay notificaciones para el filtro '$_filtroSeleccionado'.",
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: notificacionesFiltradas.length,
                          itemBuilder: (context, index) {
                            final noti = notificacionesFiltradas[index];
                            return _buildNotiItem(noti);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFiltroDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.95),
        border: Border.all(color: Colors.black12, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: _filtroSeleccionado,
        underline: Container(),
        isExpanded: true,
        icon: const Icon(Icons.filter_list, color: Color(0xFF1ABC9C)),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        items: _opcionesFiltro
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          setState(() {
            _filtroSeleccionado = value!;
          });
        },
      ),
    );
  }

  Widget _buildNotiItem(Notificacion noti) {
    final bool esNoLeida = noti.estado == "No leída";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: esNoLeida
            ? const Color(0xFFE0F7FA)
            : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: esNoLeida ? const Color(0xFFA6DFDE) : Colors.black12,
          width: esNoLeida ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5),
            child: Icon(
              esNoLeida ? Icons.circle : Icons.done_all,
              size: esNoLeida ? 10 : 18,
              color: esNoLeida ? const Color(0xFF2ECC71) : const Color(0xFF95A5A6),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noti.titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: esNoLeida ? const Color(0xFF2C3E50) : Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),

                Text(
                  noti.descripcion,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),

                Text(
                  "${noti.estado}  •  ${noti.tiempo}", 
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}