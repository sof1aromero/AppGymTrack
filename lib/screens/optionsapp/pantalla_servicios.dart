import 'package:flutter/material.dart';

class PantallaServicios extends StatelessWidget {
  const PantallaServicios({super.key});

  // Color principal para elementos de acción y fondo
  final Color _primaryColor = const Color(0xFFA6DFDE);
  final Color _darkTextColor = const Color(0xFF2C3E50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Servicios", style: TextStyle(color: _darkTextColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
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
              // --- Servicio Activo: Spinning ---
              _buildServiceCard(
                context,
                title: "Spinning",
                status: "Activo",
                statusColor: Colors.green,
                details: "Inicio: 2025-06-18\nPróximo pago: 2025-07-18\nPrecio: \$80.000 mensual",
                actionButtons: [
                  _buildActionButton("Ver detalles", () => _showDetailPopup(context, "Spinning")),
                  _buildActionButton("Cancelar", () {}),
                  _buildActionButton("Pagar", () {}, isPrimary: true),
                ],
              ),
              const SizedBox(height: 20),

              // --- Servicio Pago Pendiente: Gym Libre ---
              _buildServiceCard(
                context,
                title: "Gym Libre",
                status: "Pago pendiente",
                statusColor: Colors.amber.shade700,
                details: "Inicio: 2025-06-18\nVence: 2025-07-18\nPrecio: \$110.000 mensual",
                actionButtons: [
                  _buildActionButton("Ver detalles", () => _showDetailPopup(context, "Gym Libre")),
                  _buildActionButton("Cancelar", () {}),
                  _buildActionButton("Pagar", () {}, isPrimary: true),
                ],
              ),
              const SizedBox(height: 20),

              // --- Servicio Cancelado: Gym Pilates ---
              _buildServiceCard(
                context,
                title: "Gym Pilates",
                status: "Cancelado",
                statusColor: Colors.red,
                details: "Cancelado por el cliente\nPrecio: \$90.000 mensual",
                actionButtons: [
                  _buildActionButton("Ver detalles", () => _showDetailPopup(context, "Gym Pilates")),
                  _buildActionButton("Reactivar Servicio", () {}, isPrimary: true),
                ],
              ),
              const SizedBox(height: 40),

              // --- Botón Ver Más Servicios ---
              _buildPrimaryButton(
                "Ver más servicios +",
                () {},
                isLarge: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(context), <--- ELIMINADO
    );
  }

  // --- WIDGET PARA CADA TARJETA DE SERVICIO ---
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
          // Título y Estado
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

          // Detalles
          Text(
            details,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 20),

          // Botones de Acción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actionButtons,
          ),
        ],
      ),
    );
  }

  // --- WIDGET INDICADOR DE ESTADO ---
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

  // --- WIDGET BOTÓN DE ACCIÓN (Ver detalles, Cancelar, Pagar) ---
  Widget _buildActionButton(String text, VoidCallback onTap,
      {bool isPrimary = false}) {
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

  // --- WIDGET BOTÓN PRINCIPAL (Ver más servicios) ---
  Widget _buildPrimaryButton(String text, VoidCallback onTap,
      {bool isLarge = false}) {
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
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // --- FUNCIÓN PARA EL POPUP DE DETALLE (Segunda imagen) ---
  void _showDetailPopup(BuildContext context, String serviceName) {
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
                      color: _darkTextColor),
                ),
                const Divider(height: 25),
                const Text(
                  "Aquí irían los detalles específicos del plan, incluyendo los beneficios y condiciones de cancelación.",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
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
}