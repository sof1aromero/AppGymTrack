import 'package:flutter/material.dart';
import 'package:gymtrack/services/api_service.dart';
import '../screens/login_gymtrack.dart';

class RecuperarContrasenaPaso2 extends StatefulWidget {
  final String email;
  const RecuperarContrasenaPaso2({super.key, required this.email});

  @override
  State<RecuperarContrasenaPaso2> createState() => _RecuperarContrasenaPaso2State();
}

class _RecuperarContrasenaPaso2State extends State<RecuperarContrasenaPaso2> {
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  @override
  void dispose() {
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void _handleResetPassword(BuildContext context) async {
    final newPassword = passCtrl.text;
    const mockCode = "123456";

    if (newPassword.length < 8) {
      _showSnackBar(context, "La contraseña debe tener mínimo 8 caracteres");
      return;
    }

    if (newPassword != confirmCtrl.text) {
      _showSnackBar(context, "Las contraseñas no coinciden");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _apiService.restablecerContrasena(
        widget.email,
        mockCode,
        newPassword,
      );

      _showAlertDialog(
        "Éxito",
        "Contraseña restablecida exitosamente. Ahora puede iniciar sesión.",
        isSuccess: true,
      );

    } catch (e) {
      _showAlertDialog(
        "Error al restablecer",
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00C2A7),
      ),
    );
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
    const Color primaryColor = Color(0xFF00C2A7);
    const Color secondaryColor = Colors.black;

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
                "Restablecer Contraseña",
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
                        "Ingrese su nueva contraseña\n(mínimo 8 caracteres)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 20),

                      campo(passCtrl, "Nueva Contraseña", password: true),
                      campo(confirmCtrl, "Confirmarla", password: true),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: _isLoading ? null : () => _handleResetPassword(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 45),
                        ),
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
                          "Restablecer y Finalizar",
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