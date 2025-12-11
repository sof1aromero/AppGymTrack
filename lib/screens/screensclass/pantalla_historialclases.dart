import 'package:flutter/material.dart';
import 'pantalla_agendarclase.dart';
import 'pantalla_misclases.dart';

class PantallaHistorial extends StatefulWidget {
  final VoidCallback onVolverAClases;

  const PantallaHistorial({super.key, required this.onVolverAClases});

  @override
  State<PantallaHistorial> createState() => _PantallaHistorialState();
}

class _PantallaHistorialState extends State<PantallaHistorial> {
  String _filtroSeleccionado = 'Todas';
  String _mesSeleccionado = 'Junio';

  final List<ClaseReservada> historialCompleto = [
    ClaseReservada(
      clase: ClaseDetalle(
        nombre: "Spinning",
        instructor: "Luis Ramirez",
        duracion: "45 minutos",
        hora: "1:00 p.m.",
        cuposDisponibles: 0,
        colorPrincipal: const Color(0xFFE74C3C),
      ),
      fecha: "8 de junio de 2025",
      horaReservada: "1:00 p.m.",
      estado: "Cancelada",
    ),
    ClaseReservada(
      clase: ClaseDetalle(
        nombre: "Yoga Suave",
        instructor: "Sara P.",
        duracion: "60 minutos",
        hora: "7:00 p.m.",
        cuposDisponibles: 0,
        colorPrincipal: const Color(0xFF1ABC9C),
      ),
      fecha: "5 de mayo de 2025",
      horaReservada: "7:00 p.m.",
      estado: "Finalizada",
    ),
    ClaseReservada(
      clase: ClaseDetalle(
        nombre: "Entrenamiento Funcional",
        instructor: "David R.",
        duracion: "45 minutos",
        hora: "6:00 a.m.",
        cuposDisponibles: 0,
        colorPrincipal: const Color(0xFF1ABC9C),
      ),
      fecha: "3 de junio de 2025",
      horaReservada: "6:00 a.m.",
      estado: "Finalizada",
    ),
  ];

  List<ClaseReservada> _getFilteredClasses() {
    List<ClaseReservada> filteredByStatus;

    if (_filtroSeleccionado == 'Finalizadas') {
      filteredByStatus = historialCompleto.where((c) => c.estado == 'Finalizada').toList();
    } else if (_filtroSeleccionado == 'Canceladas') {
      filteredByStatus = historialCompleto.where((c) => c.estado == 'Cancelada').toList();
    } else {
      filteredByStatus = historialCompleto;
    }

    if (_mesSeleccionado != 'Todos') {
      filteredByStatus = filteredByStatus.where((c) => c.fecha.contains(_mesSeleccionado.toLowerCase())).toList();
    }

    return filteredByStatus;
  }

  @override
  Widget build(BuildContext context) {
    final filteredClasses = _getFilteredClasses();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial de clases",
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
          onPressed: () => Navigator.pop(context),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: _buildFilterButtons(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: _buildMonthFilter(),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    if (filteredClasses.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          "No hay clases en este historial.",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),

                    ...filteredClasses.map((clase) => _buildHistoryClassCard(context, clase)).toList(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterChip('Todas', 'Ver todas', _filtroSeleccionado == 'Todas'),
        const SizedBox(width: 8),
        _buildFilterChip('Finalizadas', 'Finalizadas', _filtroSeleccionado == 'Finalizadas'),
        const SizedBox(width: 8),
        _buildFilterChip('Canceladas', 'Canceladas', _filtroSeleccionado == 'Canceladas', selectedColor: Colors.red),
      ],
    );
  }

  Widget _buildFilterChip(String filterValue, String label, bool isSelected, {Color? selectedColor}) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        setState(() {
          _filtroSeleccionado = filterValue;
        });
      },
      backgroundColor: isSelected ? (selectedColor ?? const Color(0xFF34B5A0).withOpacity(0.8)) : Colors.white.withOpacity(0.9),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF2C3E50),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? (selectedColor ?? const Color(0xFF34B5A0)) : Colors.black26,
        width: isSelected ? 2 : 1,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget _buildMonthFilter() {
    final List<String> meses = ['Todos', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _mesSeleccionado,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF34B5A0)),
              style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
              onChanged: (String? newValue) {
                setState(() {
                  _mesSeleccionado = newValue!;
                });
              },
              items: meses.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryClassCard(BuildContext context, ClaseReservada claseReservada) {
    final Color statusColor = claseReservada.estado == 'Cancelada' ? Colors.redAccent : const Color(0xFF1ABC9C);

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
            claseReservada.clase.nombre,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),

          _buildInfoRow("Fecha:", claseReservada.fecha),
          _buildInfoRow("Hora:", claseReservada.horaReservada),
          _buildInfoRow("Instructor:", claseReservada.clase.instructor),
          _buildInfoRow("Estado:", claseReservada.estado, statusColor),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {
                print("Ver detalles de ${claseReservada.clase.nombre} - Historial");
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF34B5A0),
                side: const BorderSide(color: Color(0xFF34B5A0), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Ver detalles", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
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
            width: 90,
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

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(icon: Icons.sync_alt, label: "Mis servicios"),
          _NavBarItem(icon: Icons.credit_card, label: "Mis pagos"),
          _NavBarItem(icon: Icons.notifications_none, label: "Notificaciones"),
          _NavBarItem(icon: Icons.menu, label: "Más"),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFF34B5A0) : Colors.grey.shade600,
          size: 26,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFF34B5A0) : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}