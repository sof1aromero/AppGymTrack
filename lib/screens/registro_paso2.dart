import 'package:flutter/material.dart';

class RegistroPaso2 extends StatefulWidget {
  const RegistroPaso2({super.key});

  @override
  State<RegistroPaso2> createState() => _RegistroPaso2State();
}

class _RegistroPaso2State extends State<RegistroPaso2> {

  bool recordar = false; 
  DateTime? fechaNacimiento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFFEFEFF5),
              Color(0xFFD7E7F3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Crea tu cuenta",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
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
                        "Registro 2/2",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      campo("Teléfono*", true),
                      campo("Correo electrónico*", false),
                      campo("Dirección*", false),


                      fechaNacimientoCampo(),

                      campo("Contraseña*", false, isPassword: true),
                      campo("Confirmar contraseña*", false, isPassword: true),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            value: recordar,
                            onChanged: (value) {
                              setState(() {
                                recordar = value ?? false;
                              });
                            },
                            activeColor: Colors.tealAccent,
                          ),
                          const Text(
                            "Recordarme",
                            style: TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C2A7),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Crear cuenta",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
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



  Widget campo(String label, bool numeric, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          keyboardType: numeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE3E3E3),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }


  Widget fechaNacimientoCampo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fecha de nacimiento*", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),

        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              setState(() {
                fechaNacimiento  = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              fechaNacimiento == null
                  ? "Seleccionar fecha"
                  : "${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}
