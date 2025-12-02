import 'package:flutter/material.dart';

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6EE), Color(0xFFA6DFDE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: const [
                  CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person, size: 45),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sofia Romero",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("sofiaromero@gmail.com"),
                      Text("Usuario",
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _itemPerfil("Cambiar contraseña"),
              const SizedBox(height: 10),
              _itemPerfil("Actualizar datos personales"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemPerfil(String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.9),
      ),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text("Actualizar",
              style: TextStyle(color: Colors.lightBlue.shade700)),
        ],
      ),
    );
  }
}
