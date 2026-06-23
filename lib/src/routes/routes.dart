import 'package:flutter/material.dart';
import '../pages/lista_consultas_page.dart';
import 'package:app_gestion_abogados/src/pages/login_page.dart';
import 'package:app_gestion_abogados/src/pages/perfil_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    //agregar las otras rutas correspondientes
    '/': (BuildContext context) => const LoginPage(),
    '/perfil': (BuildContext context) => const PerfilPage(),
    //En el caso que quieran ver solamente la pantalla que estan desarrollando, comenten las demas
    '/Consultas': (BuildContext context) => const ListaConsultasPage(),
  };
}
