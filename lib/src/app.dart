import 'package:flutter/material.dart';
import 'routes/routes.dart'; // Importamos el diccionario de rutas

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1A2B4B);

    return MaterialApp(
      title: 'Gestor Jurídico',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: const Color(0xFF64748B),
          tertiary: const Color(0xFFC5A059),
        ),

        // Configuración de la AppBar centralizada
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true, // Título centrado
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      initialRoute: '/Consultas', // Ruta inicial para pruebas de la pantalla de detalle
           // Una vez se cree la pantalla de login, colocar en routes / y colocar la ruta correspondiente a la pantalla de login

      routes: getApplicationRoutes(),
    );
  }
}
