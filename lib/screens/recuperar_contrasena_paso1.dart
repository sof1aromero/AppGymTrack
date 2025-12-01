import 'package:flutter/material.dart';
import 'recuperar_contrasena_paso2.dart';

class RecuperarContrasenaPaso1 extends StatefulWidget {
  const RecuperarContrasenaPaso1({super.key});

  @override
  State<RecuperarContrasenaPaso1> createState() => _RecuperarContrasenaPaso1State();
}

class _RecuperarContrasenaPaso1State extends State<RecuperarContrasenaPaso1> {
  final TextEditingController correoCtrl = TextEditingController();
  final TextEditingController codigoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0XFFEFEFF5), Color(0xFFD7E7F3)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Recuperar Contraseña",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),

                  child: ListView(
                    children: [
                      const Text(
                        "Ingrese el correo con el que se registró",
                        style: TextStyle(fontWeight: FontWeight.bold),
                         
                      ),

                      const SizedBox(height: 15),
                      campo(correoCtrl, "Correo Electrónico"),

                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          // Aquí va tu lógica para enviar código
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: const Text("Enviar código"),
                      ),

                      const SizedBox(height: 20),

                      campo(codigoCtrl, "Ingrese el código"),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: () {
                          if (codigoCtrl.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RecuperarContrasenaPaso2()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C2A7),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: const Text("Enviar"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget campo(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
