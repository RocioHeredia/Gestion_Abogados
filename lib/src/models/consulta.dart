class Consulta {
  final String idConsulta; // Identificador para la futura base de datos
  final String cliente;
  final String tema;
  final String fecha;
  final String expediente;
  final String estado;

  // Constructor
  Consulta({
    required this.idConsulta,
    required this.cliente,
    required this.tema,
    required this.fecha,
    required this.expediente,
    required this.estado,
  });

  // Método Factory para serializar/deserializar el futuro JSON de la API REST
  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      idConsulta: json['id_consulta'].toString(),
      cliente: json['cliente'] ?? 'Sin cliente',
      tema: json['tema'] ?? 'Sin tema',
      fecha: json['fecha_ingreso'] ?? '',
      expediente: json['nro_expediente'] ?? '',
      estado:
          json['estado'] ??
          'Pendiente', // Valor por defecto si no se proporciona estado
    );
  }
}
