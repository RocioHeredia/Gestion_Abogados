class Consulta {
  final String idConsulta;
  final String cliente;
  final String tema;
  final String fecha;
  final String expediente;
  final String estado;

  final String descripcion;
  final String contacto;

  Consulta({
    required this.idConsulta,
    required this.cliente,
    required this.tema,
    required this.fecha,
    required this.expediente,
    required this.estado,
    required this.descripcion,
    required this.contacto,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      idConsulta: json['id_consulta'].toString(),
      cliente: json['cliente'] ?? 'Sin cliente',
      tema: json['tema'] ?? 'Sin tema',
      fecha: json['fecha_ingreso'] ?? '',
      expediente: json['nro_expediente'] ?? '',
      estado: json['estado'] ?? 'Pendiente',
      descripcion: json['descripcion'] ?? '',
      contacto: json['contacto'] ?? '',
    );
  }
}
