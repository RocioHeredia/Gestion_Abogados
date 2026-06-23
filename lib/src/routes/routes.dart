import 'package:flutter/material.dart';
import 'package:app_gestion_abogados/src/pages/HomePages.dart';
import 'package:app_gestion_abogados/src/pages/login_page.dart';
import 'package:app_gestion_abogados/src/pages/perfil_page.dart';

import '../pages/lista_consultas_page.dart';
import '../pages/nuevaconsulta.dart';
import '../pages/detalle_consulta_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const LoginPage(),
    '/HomePages': (BuildContext context) => const MyHomePage(),
    '/perfil': (BuildContext context) => const PerfilPage(),

    '/Consultas': (BuildContext context) => const ListaConsultasPage(),
    '/NuevaConsulta': (BuildContext context) => const NuevaConsultaPage(),
    '/detalle': (BuildContext context) => const DetalleConsultaPage(),
  };
}
