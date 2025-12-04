import 'package:flutter/material.dart';

class PantallaCambiarContrasena extends StatelessWidget {
  const PantallaCambiarContrasena({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambiar contraseña"),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text("Pantalla para cambiar la contraseña"),
      ),
    );
  }
}
