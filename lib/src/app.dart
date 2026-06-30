import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
ValueNotifier<bool> temaOscuro = ValueNotifier(false);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1A2B4B);

    return ValueListenableBuilder<bool>(
      valueListenable: temaOscuro,
      builder: (context, oscuro, child) {
        return MaterialApp(
          title: 'Gestor Jurídico',
          debugShowCheckedModeBanner: false,
          locale: const Locale('es', 'ES'),
              supportedLocales: const [
                Locale('es', 'ES'),
              ],

              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
          themeMode: oscuro ? ThemeMode.dark : ThemeMode.light,

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

            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: primaryColor),
              titleTextStyle: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          darkTheme: ThemeData.dark(useMaterial3: true),

          initialRoute: '/',
          routes: getApplicationRoutes(),
        );
      },
    );
  }
}
