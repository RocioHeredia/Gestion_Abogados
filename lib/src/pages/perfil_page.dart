import 'package:flutter/material.dart';
import 'package:app_gestion_abogados/src/widgets/menu.dart';
import 'package:app_gestion_abogados/src/models/usuario.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool modoOscuro = false;
  String nombre = Usuario.nombre; // Inicializar con el nombre del usuario';
  String correo = 'ejemploabogado@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFE8EEF9),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF0B1F4D),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          correo,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      final nombreController = TextEditingController(
                        text: nombre,
                      );
                      final correoController = TextEditingController(
                        text: correo,
                      );

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Editar Perfil'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nombreController,
                                decoration: const InputDecoration(
                                  labelText: 'Nombre',
                                ),
                              ),
                              TextField(
                                controller: correoController,
                                decoration: const InputDecoration(
                                  labelText: 'Correo',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  nombre = nombreController.text;
                                  correo = correoController.text;
                                });

                                Navigator.pop(context);
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        Text(
                          'Preferencias',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Idioma'),
                    trailing: Text('Español'),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Cambiar Contraseña'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  SwitchListTile(
                    value: modoOscuro,
                    onChanged: (value) {
                      setState(() {
                        modoOscuro = value;
                      });
                    },
                    secondary: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Modo Oscuro'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE0E0),
                  foregroundColor: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(index: 3),
    );
  }
}
