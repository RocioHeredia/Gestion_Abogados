import 'package:flutter/material.dart';
import '../pages/nuevaconsulta.dart';
import '../pages/lista_consultas_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    //agregar las otras rutas correspondientes

    //En el caso que quieran ver solamente la pantalla que estan desarrollando, comenten las demas
    '/Consultas': (BuildContext context) => const ListaConsultasPage(),
    '/NuevaConsulta': (BuildContext context) => const NuevaConsultaPage(),
  };
}
