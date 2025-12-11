import 'package:flutter/material.dart';
import 'package:gymtrack/screens/optionsapp/MenuPrincipal.dart';

import 'recuperar_contrasena_paso1.dart';
import 'registro_paso1.dart';

class LoginGymTrack extends StatefulWidget {
  const LoginGymTrack({super.key});

  @override
  State<LoginGymTrack> createState() => _LoginGymTrackState();
}

class _LoginGymTrackState extends State<LoginGymTrack> {
  String? selectedDocumentType;
  bool rememberMe = false;

  final Color _primaryColor = const Color.fromARGB(255, 92, 189, 164);
  final Color _secondaryColor = const Color(0xFFFFFFFF);
  final Color _darkOverlay = Colors.black.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/gym_bg.png", fit: BoxFit.cover),
          ),

          Container(color: _darkOverlay),

          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 70),

                    // Logo y Título
                    const Icon(
                      Icons.fitness_center,
                      size: 90,
                      color: Color.fromARGB(255, 99, 189, 166),
                    ), // MEJORA: Icono con color primario
                    const SizedBox(height: 10),
                    Text(
                      "GYM\nTRACK",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: _secondaryColor,
                        height: 1,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    _buildDropdownDocument(),

                    const SizedBox(height: 15),

                    _inputField("N° Documento", icon: Icons.person_outline),

                    const SizedBox(height: 15),

                    _inputField(
                      "Contraseña",
                      isPassword: true,
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                              activeColor: _primaryColor,
                              checkColor: Colors.black,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            const Text(
                              "Recordarme",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RecuperarContrasenaPaso1(),
                              ),
                            );
                          },
                          child: Text(
                            "Olvidé mi contraseña",
                            style: TextStyle(
                              color: _primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: _primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _button(
                      "Inicia Sesión",
                      color: _primaryColor,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuPrincipal(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    _button(
                      "No Tengo Cuenta",
                      color: Colors.white,
                      textColor: Colors.black,
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

  Widget _buildDropdownDocument() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedDocumentType,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Tipo de Documento",
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: const Icon(Icons.badge, color: Color(0xFF519483)),
        ),
        items:
            [
                  "Cédula de Ciudadanía",
                  "Tarjeta de Identidad",
                  "Permiso por Protección Temporal",
                ]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.black)),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            selectedDocumentType = value;
          });
        },
      ),
    );
  }

  Widget _inputField(String label, {bool isPassword = false, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          border: InputBorder.none,
          prefixIcon: icon != null
              ? Icon(icon, color: const Color(0xFF519483))
              : null,
          suffixIcon: isPassword
              ? Icon(Icons.visibility_off, color: Colors.grey.shade700)
              : null,
        ),
      ),
    );
  }

  Widget _button(
    String text, {
    Color color = const Color(0xFF519483),
    Color textColor = Colors.black,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.6),
        ),
        onPressed: onPressed ?? () {},
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
