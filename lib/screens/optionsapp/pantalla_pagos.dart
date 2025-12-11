import 'package:flutter/material.dart';

import '../screenspagos/historial_clases.dart';
import '../screenspagos/historial_pagos.dart';
import '../screenspagos/pantalla_servicios_pendientes.dart';

class PantallaPagos extends StatelessWidget {
  const PantallaPagos({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 45, bottom: 40),
                    child: Text(
                      "Mis pagos",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ),

                _buildPaymentCard(
                  context: context,
                  title: "Realizar pago",
                  description:
                      "Consultar los servicios pendientes y realiza el pago fácilmente.",
                  buttonText: "Ir a pagar",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaServiciosPendientes(
                          serviceName: "Membresía General",
                          price: "\$100.000",
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),

                _buildPaymentCard(
                  context: context,
                  title: "Ver historial de pagos",
                  description:
                      "Consulta tus pagos anteriores por fecha o servicio.",
                  buttonText: "Ver historial",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistorialPagosScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),

                _buildPaymentCard(
                  context: context,
                  title: "Ver historial de clases",
                  description: "Mira las clases que ya tomaste o cancelaste.",
                  buttonText: "Ver historial",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistorialClasesScreen(),
                      ),
                    );
                  },
                ),

                // ESPACIO INFERIOR AUMENTADO
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required BuildContext context,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    const Color primaryColor = Color(0xFF34B5A0);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1.5),
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
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),

          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor.withOpacity(0.8),
                    width: 2.5,
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
