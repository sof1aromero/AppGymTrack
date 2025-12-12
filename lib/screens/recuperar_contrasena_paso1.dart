import 'package:flutter/material.dart';
import 'package:gymtrack/services/api_service.dart';
import 'recuperar_contrasena_paso2.dart';

class RecuperarContrasenaPaso1 extends StatefulWidget {
  const RecuperarContrasenaPaso1({super.key});

  @override
  State<RecuperarContrasenaPaso1> createState() => _RecuperarContrasenaPaso1State();
}

class _RecuperarContrasenaPaso1State extends State<RecuperarContrasenaPaso1> {
  final TextEditingController correoCtrl = TextEditingController();
  final TextEditingController codigoCtrl = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isLoadingRequestCode = false;
  bool _isCodeSent = false;
  String _requestedEmail = '';

  @override
  void dispose() {
    correoCtrl.dispose();
    codigoCtrl.dispose();
    super.dispose();
  }

  void _handleRequestCode() async {
    final email = correoCtrl.text;

    if (email.isEmpty) {
      _showAlertDialog("Advertencia", "Por favor, ingrese su correo electrónico.");
      return;
    }

    setState(() => _isLoadingRequestCode = true);

    try {
      await _apiService.solicitarCodigoRecuperacion(email);

      setState(() {
        _isCodeSent = true;
        _requestedEmail = email;
      });

      _showAlertDialog("Código Enviado", "El código de verificación ha sido enviado a $email. (Código simulado: 123456)", isSuccess: true);

    } catch (e) {
      _showAlertDialog("Error al solicitar código", e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoadingRequestCode = false);
    }
  }

  void _handleVerifyCode() {
    final code = codigoCtrl.text;

    if (!_isCodeSent) {
      _showAlertDialog("Advertencia", "Primero debe solicitar el código de recuperación.");
      return;
    }

    if (code.isEmpty) {
      _showAlertDialog("Advertencia", "Por favor, ingrese el código de verificación.");
      return;
    }

    if (_requestedEmail.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RecuperarContrasenaPaso2(email: _requestedEmail),
        ),
      );
    }
  }

  void _showAlertDialog(String title, String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(isSuccess ? 'Entendido' : 'Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00C2A7);
    final Color secondaryColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: secondaryColor,
      ),
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
              Text(
                "Recuperar Contraseña",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),

                      const SizedBox(height: 15),
                      campo(correoCtrl, "Correo Electrónico"),

                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: _isLoadingRequestCode ? null : _handleRequestCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: _isLoadingRequestCode
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text("Enviar código"),
                      ),

                      const SizedBox(height: 20),

                      if (_isCodeSent)
                        Text(
                          "Código enviado a: ${_requestedEmail}. Ahora ingréselo abajo.",
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                      const SizedBox(height: 10),

                      campo(codigoCtrl, "Ingrese el código"),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: _handleVerifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: const Text(
                          "Verificar y Continuar",
                          style: TextStyle(color: Colors.white),
                        ),
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
        keyboardType: hint.contains('Correo') ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}