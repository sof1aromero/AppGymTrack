
class ServicioModel {
  final int id;
  final String nombre;
  final String estado; 
  final String detalles;
  

  ServicioModel({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.detalles,
  });


  factory ServicioModel.fromJson(Map<String, dynamic> json) {
    return ServicioModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      estado: json['estado'] as String,
      detalles: json['detalles'] as String,
    );
  }
}