import 'package:flutter/material.dart';

class PantallaActualizarDatos extends StatelessWidget {
  const PantallaActualizarDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar datos"),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text("Pantalla para actualizar los datos personales"),
      ),
    );
  }
}
