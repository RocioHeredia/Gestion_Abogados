import 'package:flutter/material.dart';
import 'package:app_gestion_abogados/src/models/usuario.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool mantenerSesion = false;
  bool ocultarPassword = true;
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.black12),
                    ],
                  ),
                  child: const Icon(
                    Icons.gavel,
                    size: 40,
                    color: Color(0xFF0B1F4D),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Gestor de Consultas\nJurídicas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1F4D),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Acceso seguro a su portal profesional',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 35),

                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'USUARIO',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: usuarioController,
                          decoration: const InputDecoration(
                            hintText: 'Ingrese su usuario',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                          'CONTRASEÑA',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('¿Olvidó su contraseña?'),
                          ),
                        ),

                        TextField(
                          controller: passwordController,
                          obscureText: ocultarPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                ocultarPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  ocultarPassword = !ocultarPassword;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Checkbox(
                              value: mantenerSesion,
                              onChanged: (value) {
                                setState(() {
                                  mantenerSesion = value ?? false;
                                });
                              },
                            ),
                            const Text('Mantener sesión iniciada'),
                          ],
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B1F4D),
                            ),
                            onPressed: () {
                              if (usuarioController.text.trim().isEmpty ||
                                  passwordController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Debe completar usuario y contraseña',
                                    ),
                                  ),
                                );
                                return;
                              }

                              Usuario.nombre = usuarioController.text;

                              Navigator.pushReplacementNamed(
                                context,
                                '/HomePages',
                              );
                            },
                            child: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  '© 2024 Sistema Integrado de Gestión Legal.\nTodos los derechos reservados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
