import 'package:flutter/material.dart';
import 'registro_paso1.dart';

class LoginGymTrack extends StatefulWidget {
  const LoginGymTrack({super.key});

  @override
  State<LoginGymTrack> createState() => _LoginGymTrackState();
}

class _LoginGymTrackState extends State<LoginGymTrack> {
  String? selectedDocumentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla
          SizedBox.expand(
            child: Image.asset(
              "assets/images/gym_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          // Capa oscura
          Container(
            color: Colors.black.withOpacity(0.45),
          ),

          // Contenido
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  children: [
                    const SizedBox(height: 50),

                    // LOGO
                    const Icon(Icons.fitness_center, size: 90, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      "GYM\nTRACK",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Selección tipo de documento
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedDocumentType,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Tipo de Documento",
                        ),
                        items: [
                          "Cédula",
                          "Tarjeta de Identidad",
                          "Pasaporte",
                        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDocumentType = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    _inputField("N° Documento"),

                    const SizedBox(height: 15),

                    _inputField("Contraseña", isPassword: true),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Colors.tealAccent,
                        ),
                        const Text("Recordarme", style: TextStyle(color: Colors.white)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // botón iniciar sesión
                    _button("Inicia Sesión"),

                    const SizedBox(height: 10),

                    // botón no tengo cuenta → REGISTRO
                    _button(
                      "No Tengo Cuenta",
                      color: Colors.cyanAccent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistroPaso1(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------- Widgets reutilizables ----------

  Widget _inputField(String label, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _button(String text, {Color color = Colors.tealAccent, VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed ?? () {},
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
