import 'package:flutter/material.dart';

class PantallaActualizarDatos extends StatefulWidget {
  const PantallaActualizarDatos({super.key});

  @override
  State<PantallaActualizarDatos> createState() =>
      _PantallaActualizarDatosState();
}

class _PantallaActualizarDatosState extends State<PantallaActualizarDatos> {
  final TextEditingController _tipdocumentoController = TextEditingController(
    text: 'Cédula de ciudadanía',
  );
  final TextEditingController _numDocumentoController = TextEditingController(
    text: '123456789',
  );
  final TextEditingController _nombreController = TextEditingController(
    text: 'Sofia Romero',
  );
  final TextEditingController _correoController = TextEditingController(
    text: 'sofiaromero@gmail.com',
  );
  final TextEditingController _telefonoController = TextEditingController(
    text: '3025457894',
  );
  final TextEditingController _direccionController = TextEditingController(
    text: 'Calle 123 #45-67',
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                '¡Tus datos se han actualizado correctamente!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _guardarDatos(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Actualizar Datos Personales",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF34B5A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Ingresa o actualiza tus datos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              const Text(
                'Tipo de documento',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _tipdocumentoController,
                enabled: false, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. Cédula de ciudadanía',
                ),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Número de documento',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _numDocumentoController,
                keyboardType: TextInputType.number,
                enabled: false, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. 123456789',
                ),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Nombre Completo',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _nombreController,
                enabled: false, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. Sofia Romero',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'El nombre es requerido' : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Correo electrónico',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. correo@dominio.com',
                ),
                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Correo inválido'
                    : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Teléfono',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. 300 123 4567',
                ),
                validator: (value) =>
                    value!.length < 7 ? 'Teléfono incompleto' : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'Dirección',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ej. Calle 123 #45-67',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'La dirección es requerida' : null,
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _guardarDatos(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
