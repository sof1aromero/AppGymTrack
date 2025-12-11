import 'package:flutter/material.dart';

// Importa todas tus pantallas
import 'pantalla_mas.dart';
import 'pantalla_servicios.dart';
import 'pantalla_pagos.dart';
import 'pantalla_notificaciones.dart';
import '../optionsapp/pantalla_clases_menu.dart'; // Importación de la pantalla de clases

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int currentIndex = 0;
  bool _showClases = false; // Estado para controlar la visibilidad de la pantalla de Clases

  void _onNavigateToTab(int index) {
    setState(() {
      currentIndex = index;
      _showClases = false; // Oculta Clases al cambiar de pestaña
    });
  }

  void _onNavigateToClass() {
    setState(() {
      _showClases = true; // Muestra la pantalla de Clases
    });
  }

  @override
  Widget build(BuildContext context) {
    // Las 4 pantallas originales
    final List<Widget> screens = [
      const PantallaServicios(),
      const PantallaPagos(),
      const PantallaNotificaciones(),
      PantallaMas(
        onNavigateToTab: _onNavigateToTab,
        onNavigateToClass: _onNavigateToClass,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // 1. Contenido principal (IndexedStack)
          IndexedStack(
            index: currentIndex,
            children: screens,
          ),

          // 2. Pantalla de Clases (Overlay condicional)
          if (_showClases)
            Positioned.fill(
              child: PantallaClasesMenu(
                // 🔑 SOLUCIÓN DE ERROR: Pasar una función no nula al onClose
                onClose: () {
                  setState(() {
                    _showClases = false; // Oculta la pantalla
                  });
                },
              ),
            ),
        ],
      ),

      bottomNavigationBar: Container(
        // Añade el código de tu BottomNavigationBar si lo tienes aquí
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            _onNavigateToTab(index);
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: "Mis servicios",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Mis pagos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notificaciones",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Más"),
          ],
        ),
      ),
    );
  }
}