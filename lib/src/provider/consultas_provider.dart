import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/consulta.dart'; // Importamos tu modelo

class _ConsultasProvider {
  // Lista dinámica ya tipada con tu modelo
  List<Consulta> opciones = [];

  _ConsultasProvider();

  Future<List<Consulta>> cargarData() async {
    // Optimización: si ya tiene datos, los retorna
    if (opciones.isNotEmpty) return opciones;

    final resp = await rootBundle.loadString('data/consultas.json');

    // Lo decodificamos como 'dynamic' para que no explote si es un Mapa o una Lista
    final dynamic decodedData = json.decode(resp);

    List<dynamic> listaCruda = [];

    // Lógica defensiva inteligente:
    if (decodedData is List) {
      // Si el JSON empieza con corchete [ ], es una lista directa
      listaCruda = decodedData;
    } else if (decodedData is Map) {
      // Si el JSON empieza con llaves { }, es un mapa.
      // Buscamos automáticamente la lista adentro de ese mapa.
      listaCruda =
          decodedData.values.firstWhere(
                (elemento) => elemento is List,
                orElse: () => [],
              )
              as List<dynamic>;
    }

    // Transformamos la lista cruda en objetos de Dart usando tu Factory
    opciones = listaCruda.map((item) => Consulta.fromJson(item)).toList();

    return opciones;
  }
}

// Se crea la instancia global del Provider
final consultasProvider = _ConsultasProvider();
