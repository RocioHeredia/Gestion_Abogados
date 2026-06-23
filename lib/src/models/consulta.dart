class Consulta {
  int? idConsulta; // Identificador opcional para la futura base de datos
  String cliente;
  String tema;
  String fecha;
  String expediente;
  String estado;

  // Constructor
  Consulta({
    this.idConsulta,
    required this.cliente,
    required this.tema,
    required this.fecha,
    required this.expediente,
    required this.estado,
  });

  // Mapeo inteligente y defensivo
  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      idConsulta: int.tryParse(
        json['id_consulta']?.toString() ?? json['id']?.toString() ?? '',
      ),
      cliente: json['cliente'] ?? 'Sin cliente',
      tema: json['tema'] ?? 'Sin tema',
      fecha: json['fecha'] ?? json['fecha_ingreso'] ?? 'Sin fecha',
      expediente:
          json['expediente'] ?? json['nro_expediente'] ?? 'Sin expediente',
      estado: json['estado'] ?? 'Pendiente',
    );
  }
}
