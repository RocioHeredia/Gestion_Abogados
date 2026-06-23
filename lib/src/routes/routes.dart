import 'package:flutter/material.dart';
import '../pages/nuevaconsulta.dart';
import '../pages/lista_consultas_page.dart';
import '../pages/detalle_consulta_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // Rutas correspondientes unificadas con éxito 
    '/Consultas': (BuildContext context) => const ListaConsultasPage(),
    '/NuevaConsulta': (BuildContext context) => const NuevaConsultaPage(),
    '/detalle': (BuildContext context) => const DetalleConsultaPage(),
  };
}
