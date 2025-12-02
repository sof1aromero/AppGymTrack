import 'package:flutter/material.dart';

enum PaymentStatus {
  initial,
  pending,
  success,
}

class PantallaServiciosPendientes extends StatefulWidget {
  const PantallaServiciosPendientes({super.key});

  @override
  State<PantallaServiciosPendientes> createState() =>
      _PantallaServiciosPendientesState();
}

class _PantallaServiciosPendientesState
    extends State<PantallaServiciosPendientes> {
  PaymentStatus _status = PaymentStatus.initial;


  final String _servicioNombre = "Spinnig";
  final String _servicioPrecio = "\$80.000";
  final String _servicioVencimiento = "2023-08-30";
  final String _servicioEstado = "Pendiente";
  

  final Color _primaryColor = const Color(0xFFA6DFDE);


  void _confirmarPago() {
    setState(() {
      _status = PaymentStatus.pending;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _status = PaymentStatus.success;
      });
    });
  }

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildConfirmationDialog(context);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios pendientes de pago",
            style: TextStyle(color: Color(0xFF2C3E50))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6EE), Color(0xFFA6DFDE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [

                _buildServiceDetailCard(),
                
                const Spacer(),


                if (_status == PaymentStatus.success)
                  _buildSuccessOverlay(context)
                else
                  const SizedBox.shrink(),


                _buildBackButton(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  

  Widget _buildServiceDetailCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Servicio:", _servicioNombre, isTitle: true),
          _buildInfoRow("Precio:", "$_servicioPrecio mensual"),
          _buildInfoRow("Estado:", _servicioEstado, isStatus: true),
          _buildInfoRow("Próximo pago:", _servicioVencimiento),
          const SizedBox(height: 20),

          // --- Botón de PAGO ---
          if (_status == PaymentStatus.initial)
            ElevatedButton(
              onPressed: _mostrarConfirmacion, 
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Pagar ahora", style: TextStyle(fontSize: 16)),
            )
          else
            const SizedBox.shrink(), 
        ],
      ),
    );
  }
  

  Widget _buildInfoRow(String label, String value,
      {bool isTitle = false, bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isStatus ? FontWeight.bold : FontWeight.normal,
              color: isStatus ? Colors.red.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.all(25),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.grey),
              const SizedBox(width: 10),
              Text("Confirmar Pago",
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const Divider(),
          _buildInfoRow("Servicio:", _servicioNombre),
          _buildInfoRow("Total:", _servicioPrecio, isTitle: true),
          const SizedBox(height: 20),
          const Text("¿Deseas realizar el pago ahora?"),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                  _confirmarPago(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Confirmar Pago"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessOverlay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 40),
          const SizedBox(height: 10),
          const Text("¡Pago realizado con éxito!",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 20),
          _buildActionButton("Ver factura", () {}),
          _buildActionButton("Descargar factura", () {}),
          _buildActionButton("Volver al área de pagos", () {
            Navigator.of(context).pop(); 
          }),
        ],
      ),
    );
  }
  

  Widget _buildActionButton(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 146, 216, 210), // Color oscuro
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(); 
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        padding: const EdgeInsets.all(0),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [_primaryColor, _primaryColor.withOpacity(0.7)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _primaryColor.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Text(
          "Volver a Mis pagos",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}