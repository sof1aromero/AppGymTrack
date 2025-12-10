import 'package:flutter/material.dart';

import 'pantalla_perfil.dart';

import '../optionsapp/pantalla_servicios.dart';
import '../optionsapp/pantalla_pagos.dart';
import '../optionsapp/pantalla_notificaciones.dart';

class PantallaMas extends StatelessWidget {
  const PantallaMas({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 40),
                    child: Text(
                      "Mi Cuenta",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ),

                _buildProfileCard(context),

                const SizedBox(height: 30),

                _buildSectionTitle("General"),
                _item(
                  context: context,
                  text: "Mis servicios",
                  icon: Icons.fitness_center_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaServicios(),
                      ),
                    );
                  },
                ),
                _item(
                  context: context,
                  text: "Clases",
                  icon: Icons.calendar_month_outlined,
                  onTap: () {
                    print("Navegar a Clases");
                  },
                ),
                _item(
                  context: context,
                  text: "Mis pagos",
                  icon: Icons.credit_card_outlined,
                  onTap: () {
                    print("Navegar a Mis Pagos");
                  },
                ),
                _item(
                  context: context,
                  text: "Notificaciones",
                  icon: Icons.notifications_none_outlined,
                  onTap: () {
                    print("Navegar a Notificaciones");
                  },
                ),

                const SizedBox(height: 30),
                _buildSectionTitle("Soporte y Salir"),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "¿Tienes algún incidente?, repórtalo\ndesde la página web.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cerrando sesión...')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.shade100,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "Cerrar sesión",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFA6DFDE),
            child: Icon(Icons.person, size: 40, color: Color(0xFF2C3E50)),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Sofia Romero",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("sofiaromero@gmail.com", style: TextStyle(fontSize: 14)),
              Text(
                "Usuario",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),

          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF1ABC9C)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaPerfil()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1ABC9C)),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
