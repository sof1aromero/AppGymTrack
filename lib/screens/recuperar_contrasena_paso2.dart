import 'package:flutter/material.dart';

class RecuperarContrasenaPaso2 extends StatefulWidget {
  const RecuperarContrasenaPaso2({super.key});

  @override
  State<RecuperarContrasenaPaso2> createState() => _RecuperarContrasenaPaso2State();
}

class _RecuperarContrasenaPaso2State extends State<RecuperarContrasenaPaso2> {
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

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
                        "Ingrese su nueva contraseña\n(mínimo 8 caracteres)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 20),

                      campo(passCtrl, "Nueva Contraseña", password: true),
                      campo(confirmCtrl, "Confirmarla", password: true),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: () {
                          if (passCtrl.text.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("La contraseña debe tener mínimo 8 caracteres")),
                            );
                            return;
                          }

                          if (passCtrl.text != confirmCtrl.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Las contraseñas no coinciden")),
                            );
                            return;
                          }

                          // Aquí iría tu lógica final
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

  Widget campo(TextEditingController controller, String hint, {bool password = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
