import 'package:flutter/material.dart';

import 'registro_paso2.dart';

class RegistroPaso1 extends StatefulWidget {
  const RegistroPaso1({super.key});

  @override
  State<RegistroPaso1> createState() => _RegistroPaso1State();
}

class _RegistroPaso1State extends State<RegistroPaso1> {
  String? tipoDocumento;

  // Controladores de campos obligatorios
  final TextEditingController primerNombreCtrl = TextEditingController();
  final TextEditingController primerApellidoCtrl = TextEditingController();
  final TextEditingController numeroDocumentoCtrl = TextEditingController();

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
                        "Registro 1/2",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // CAMPOS OBLIGATORIOS CON CONTROLADORES
                      campoObligatorio("Primer nombre*", primerNombreCtrl),
                      campo("Segundo nombre (opcional)", false),
                      campoObligatorio("Primer apellido*", primerApellidoCtrl),
                      campo("Segundo apellido (opcional)", false),

                      const SizedBox(height: 10),
                      const Text("Tipo de documento*",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3E3E3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: tipoDocumento,
                            hint: const Text("Seleccione"),
                            items: const [
                              DropdownMenuItem(
                                value: "CC",
                                child: Text("Cédula de Ciudadanía"),
                              ),
                              DropdownMenuItem(
                                value: "TI",
                                child: Text("Tarjeta de Identidad"),
                              ),
                              DropdownMenuItem(
                                value: "PPT",
                                child: Text("Permiso por Protección Temportal"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                tipoDocumento = value;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      campoObligatorio("Número de documento*", numeroDocumentoCtrl,
                          numeric: true),

                      const SizedBox(height: 25),

   
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C2A7),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: validarYContinuar,
                        child: const Text(
                          "Siguiente",
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


  void validarYContinuar() {
    if (primerNombreCtrl.text.isEmpty ||
        primerApellidoCtrl.text.isEmpty ||
        numeroDocumentoCtrl.text.isEmpty ||
        tipoDocumento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor complete todos los campos obligatorios."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

// si llena todo pasa a registro 2
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegistroPaso2()),
    );
  }



  Widget campoObligatorio(String label, TextEditingController controller,
      {bool numeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
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

  Widget campo(String label, bool numeric) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
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
}
