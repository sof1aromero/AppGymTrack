import 'package:flutter/material.dart';

import '../optionsapp/pantalla_mas.dart';
import '../perfilupdate/pantalla_actualizar_datos.dart';
import '../perfilupdate/pantalla_cambiar_contraseña.dart'; 

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PantallaMas()),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6EE), Color(0xFF34B5A0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 38,
                    child: Icon(Icons.person, size: 50),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sofia Romero",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("sofiaromero@gmail.com"),
                      Text(
                        "Usuario",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              _itemPerfil(
                context,
                text: "Cambiar contraseña",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PantallaCambiarContrasena()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _itemPerfil(
                context,
                text: "Actualizar datos personales",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PantallaActualizarDatos()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemPerfil(BuildContext context,
      {required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.95),
        ),
        child: Row(
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(
              "Actualizar",
              style: TextStyle(color: Colors.lightBlue.shade700),
            ),
          ],
        ),
      ),
    );
  }
}