import 'package:flutter/material.dart';

import '../screenspagos/pantalla_servicios_pendientes.dart';

class PantallaServicios extends StatelessWidget {
  const PantallaServicios({super.key});

  final Color _primaryColor = const Color(0xFF34B5A0);
  final Color _darkTextColor = const Color(0xFF2C3E50);

  @override
  Widget build(BuildContext context) {
    const String spinningDetails =
        "Clases dirigidas con entrenador, rutinas de alta intensidad y música. Reserva necesaria en la app.";
    const String gymLibreDetails =
        "Acceso total a máquinas, pesas y área de cardio durante el horario de atención. No incluye clases dirigidas.";
    const String gymPilatesDetails =
        "Sesiones enfocadas en el control corporal, flexibilidad y respiración. Se realiza con bandas y colchonetas.";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFE3E6EE), _primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 40),
                  child: Text(
                    "Mis servicios",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ),
              _buildServiceCard(
                context,
                title: "Spinning",
                status: "Activo",
                statusColor: Colors.green,
                details:
                    "Inicio: 2025-06-18\nPróximo pago: 2025-07-18\nPrecio: \$80.000 mensual",
                actionButtons: [
                  _buildActionButton(
                    "Ver detalles",
                    () =>
                        _showDetailPopup(context, "Spinning", spinningDetails),
                  ),
                  _buildActionButton(
                    "Cancelar",
                    () => _showCancelPopup(context, "Spinning"),
                  ),
                  _buildActionButton(
                    "Pagar",
                    () => _navigateToPagosPendientes(
                      context,
                      "Spinning",
                      "\$80.000",
                    ),
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildServiceCard(
                context,
                title: "Gym Libre",
                status: "Pago pendiente",
                statusColor: Colors.amber,
                details:
                    "Inicio: 2025-06-18\nVence: 2025-07-18\nPrecio: \$110.000 mensual",
                actionButtons: [
                  _buildActionButton(
                    "Ver detalles",
                    () =>
                        _showDetailPopup(context, "Gym Libre", gymLibreDetails),
                  ),
                  _buildActionButton(
                    "Cancelar",
                    () => _showCancelPopup(context, "Gym Libre"),
                  ),
                  _buildActionButton(
                    "Pagar",
                    () => _navigateToPagosPendientes(
                      context,
                      "Gym Libre",
                      "\$110.000",
                    ),
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildServiceCard(
                context,
                title: "Gym Pilates",
                status: "Cancelado",
                statusColor: Colors.red,
                details: "Cancelado por el cliente\nPrecio: \$90.000 mensual",
                actionButtons: [
                  _buildActionButton(
                    "Ver detalles",
                    () => _showDetailPopup(
                      context,
                      "Gym Pilates",
                      gymPilatesDetails,
                    ),
                  ),
                  _buildActionButton(
                    "Reactivar Servicio",
                    () => _reactivateService(context, "Gym Pilates"),
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildPrimaryButton(
                "Ver más servicios +",
                () => _showSnackbar(context, "Navegar a Servicios Disponibles"),
                isLarge: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required String details,
    required List<Widget> actionButtons,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkTextColor,
                ),
              ),
              const Spacer(),
              _buildStatusIndicator(status, statusColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            details,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actionButtons,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String status, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 5),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? _primaryColor : Colors.black87,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    VoidCallback onTap, {
    bool isLarge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: isLarge ? 18 : 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [_primaryColor, _primaryColor.withOpacity(0.7)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _primaryColor.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showDetailPopup(
    BuildContext context,
    String serviceName,
    String serviceDescription,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: 300,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detalle del servicio → $serviceName",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _darkTextColor,
                  ),
                ),
                const Divider(height: 25),
                Text(
                  serviceDescription,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                _buildPrimaryButton(
                  "Volver a mis servicios",
                  () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCancelPopup(BuildContext context, String serviceName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.black, size: 48),
              const SizedBox(height: 20),
              Text(
                "¿Desea cancelar su servicio de $serviceName?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _darkTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Al cancelar, perderá el acceso a este servicio inmediatamente. Esta acción es irreversible.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: const Text(
                    "Confirmar cancelación",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSnackbar(
                      context,
                      "Cancelación confirmada para $serviceName",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // NEGRO
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF34B5A0),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Mantener servicio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToPagosPendientes(
    BuildContext context,
    String serviceName,
    String price,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PantallaServiciosPendientes(serviceName: serviceName, price: price),
      ),
    );
  }

  void _reactivateService(BuildContext context, String serviceName) {
    _showSnackbar(
      context,
      "Solicitud de Reactivación enviada para $serviceName",
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Acción: $message")));
  }
}
