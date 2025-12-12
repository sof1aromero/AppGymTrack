import 'package:flutter/material.dart';
import 'package:gymtrack/services/api_service.dart';
import '../screens/login_gymtrack.dart';

class RegistroPaso2 extends StatefulWidget {
  final Map<String, dynamic> datosPaso1;

  const RegistroPaso2({super.key, required this.datosPaso1});

  @override
  State<RegistroPaso2> createState() => _RegistroPaso2State();
}

class _RegistroPaso2State extends State<RegistroPaso2> {
  final TextEditingController _telefonoCtrl = TextEditingController();
  final TextEditingController _correoCtrl = TextEditingController();
  final TextEditingController _direccionCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  final ApiService _apiService = ApiService();

  bool recordar = false;
  DateTime? fechaNacimiento;
  bool _isLoading = false;

  @override
  void dispose() {
    _telefonoCtrl.dispose();
    _correoCtrl.dispose();
    _direccionCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final telefono = _telefonoCtrl.text;
    final email = _correoCtrl.text;
    final direccion = _direccionCtrl.text;
    final password = _passCtrl.text;

    if ([telefono, email, direccion, password].any((text) => text.isEmpty) || fechaNacimiento == null) {
      _showAlertDialog("Advertencia", "Por favor, complete todos los campos requeridos.");
      return;
    }
    if (password.length < 8) {
      _showAlertDialog("Advertencia", "La contraseña debe tener mínimo 8 caracteres.");
      return;
    }
    if (password != _confirmPassCtrl.text) {
      _showAlertDialog("Advertencia", "Las contraseñas no coinciden.");
      return;
    }

    setState(() => _isLoading = true);

    final Map<String, dynamic> datosCompletos = {
      'primerNombre': widget.datosPaso1['primerNombre'] ?? '',
      'primerApellido': widget.datosPaso1['primerApellido'] ?? '',
      'tipoDocumento': widget.datosPaso1['tipoDocumento'] ?? 'CC',
      'numeroDocumento': widget.datosPaso1['numeroDocumento'] ?? '1000',

      'telefono': telefono,
      'email': email,
      'direccion': direccion,
      'fechaNacimiento': fechaNacimiento!.toIso8601String().split('T').first,
      'password': password,
      'recordarme': recordar,

      'nombreCompleto': widget.datosPaso1['nombre'] ?? 'Nuevo Usuario',
    };

    try {
      await _apiService.registrarUsuario(datosCompletos);

      _showAlertDialog(
        "¡Registro Exitoso!",
        "Su cuenta ha sido creada. Ahora puede iniciar sesión.",
        isSuccess: true,
      );

    } catch (e) {
      _showAlertDialog(
        "Error en el Registro",
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showAlertDialog(String title, String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginGymTrack()),
                      (Route<dynamic> route) => false,
                );
              }
            },
            child: Text(isSuccess ? 'Ir al Login' : 'Cerrar'),
          ),
        ],
      ),
    );
  }

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

                      campo("Teléfono*", true, controller: _telefonoCtrl),
                      campo("Correo electrónico*", false, controller: _correoCtrl),
                      campo("Dirección*", false, controller: _direccionCtrl),


                      fechaNacimientoCampo(),

                      campo("Contraseña*", false, isPassword: true, controller: _passCtrl),
                      campo("Confirmar contraseña*", false, isPassword: true, controller: _confirmPassCtrl),

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
                            activeColor: const Color(0xFF00C2A7),
                            checkColor: Colors.white,
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
                        onPressed: _isLoading ? null : _handleRegister,
                        child: _isLoading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
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

  Widget campo(String label, bool numeric, {bool isPassword = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
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
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}