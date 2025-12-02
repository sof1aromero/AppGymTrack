import 'package:flutter/material.dart';

import 'pantalla_mas.dart';
import 'pantalla_notificaciones.dart';
import 'pantalla_pagos.dart';
import 'pantalla_servicios.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int currentIndex = 0;

  final List<Widget> screens = [
    PantallaServicios(),
    PantallaPagos(),
    PantallaNotificaciones(),
    PantallaMas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB9D9E8), Color(0xFFA6DFDE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
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
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Más",
            ),
          ],
        ),
      ),
    );
  }
}
