import 'package:flutter/material.dart';

enum PaymentStatus {
  initial,
  pending,
  success,
}

class PantallaServiciosPendientes extends StatefulWidget {
  final String serviceName;
  final String price;

  const PantallaServiciosPendientes({
    super.key,
    required this.serviceName,
    required this.price,
  });

  @override
  State<PantallaServiciosPendientes> createState() =>
      _PantallaServiciosPendientesState();
}

class _PantallaServiciosPendientesState
    extends State<PantallaServiciosPendientes> {
  PaymentStatus _status = PaymentStatus.initial;

  final Color _primaryColor = const Color(0xFFA6DFDE);
  final Color _darkTextColor = const Color(0xFF2C3E50);

  String get _servicioNombre => widget.serviceName;
  String get _servicioPrecio => widget.price;
  
  final String _servicioVencimiento = "2025-07-18";
  final String _servicioEstado = "Pendiente";
  
  void _confirmarPago() {
    setState(() {
      _status = PaymentStatus.pending;
    });

    Future.delayed(const Duration(seconds: 2), () {
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
        title: Text("Pago de: $_servicioNombre",
            style: TextStyle(color: _darkTextColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: _darkTextColor),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFE3E6EE), _primaryColor],
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
                else if (_status == PaymentStatus.pending)
                  _buildLoadingOverlay()
                else
                  const SizedBox.shrink(),
                
                if (_status != PaymentStatus.success) 
                  _buildBackButton(context)
                else
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
          _buildInfoRow("Vencimiento:", _servicioVencimiento),
          const SizedBox(height: 20),
          
          if (_status == PaymentStatus.initial)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _mostrarConfirmacion, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("Pagar $_servicioPrecio ahora", 
                  style: TextStyle(fontSize: 16, color: _darkTextColor)),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value,
      {bool isTitle = false, bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
                color: _darkTextColor),
          ),
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
              Icon(Icons.payment, color: _primaryColor),
              const SizedBox(width: 10),
              Text("Confirmar Pago",
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const Divider(),
          _buildInfoRow("Servicio:", _servicioNombre),
          _buildInfoRow("Total a pagar:", _servicioPrecio, isTitle: true),
          const SizedBox(height: 20),
          const Text("Al confirmar, se procesará el pago a través de su método predeterminado."),
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
                child: Text("Confirmar Pago", style: TextStyle(color: _darkTextColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: _primaryColor),
          const SizedBox(height: 15),
          Text("Procesando pago de $_servicioPrecio...",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _darkTextColor)),
          const Text("Por favor, espere un momento.",
              style: TextStyle(color: Colors.black54)),
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
            color: Colors.green.withOpacity(0.3),
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
          Text("¡Pago de $_servicioPrecio realizado con éxito!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 20),
          _buildActionButton("Ver detalles del servicio", () => Navigator.of(context).pop()),
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
            backgroundColor: _primaryColor, 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(text, style: TextStyle(fontSize: 16, color: _darkTextColor)),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
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
              colors: [_primaryColor.withOpacity(0.8), _primaryColor],
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
          child: Text(
            "Volver a Mis Servicios",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: _darkTextColor),
          ),
        ),
      ),
    );
  }
}