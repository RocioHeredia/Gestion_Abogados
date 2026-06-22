import 'package:flutter/material.dart';

class NuevaConsultaPage extends StatefulWidget {
  const NuevaConsultaPage({super.key});

  @override
  State<NuevaConsultaPage> createState() => _NuevaConsultaPageState();
}

class _NuevaConsultaPageState extends State<NuevaConsultaPage> {
  
  // Controladores de los campos de texto
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController expedienteController = TextEditingController();

  // Variables para el Dropdown
  final List<String> opcionesEstado = ['Pendiente', 'En análisis', 'Resuelto'];
  String estadoSeleccionado = 'Pendiente';

  @override
  void dispose() {
    clienteController.dispose();
    temaController.dispose();
    expedienteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            // CAMPO: CLIENTE
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(
                labelText: 'Cliente',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // CAMPO: TEMA
            TextField(
              controller: temaController,
              decoration: const InputDecoration(
                labelText: 'Tema',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // CAMPO: EXPEDIENTE
            TextField(
              controller: expedienteController,
              decoration: const InputDecoration(
                labelText: 'Expediente',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // CAMPO: DROPDOWN DE ESTADO
            DropdownButtonFormField<String>(
              initialValue: estadoSeleccionado,
              decoration: const InputDecoration(
                labelText: 'Estado de la Consulta',
                border: OutlineInputBorder(),
              ),
              items: opcionesEstado.map((String estado) {
                return DropdownMenuItem<String>(
                  value: estado,
                  child: Text(estado),
                );
              }).toList(),
              onChanged: (nuevoValor) {
                setState(() {
                  estadoSeleccionado = nuevoValor!;
                });
              },
            ),

            const SizedBox(height: 30), // Espacio más amplio antes del botón

            // ====================================================================
            // NUEVO COMPONENTE: BOTÓN ELEVADO DE GUARDAR
            // ====================================================================
            ElevatedButton(
              // style: Personalizamos el botón usando el esquema de colores de la app.
              // Usamos el azul marino corporativo de fondo y texto blanco.
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15), // Botón más grueso y cómodo de tocar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes sutilmente redondeados
                ),
              ),
              
              // onPressed: Función anónima que se ejecuta inmediatamente al hacer clic.
              onPressed: () {
                // Capturamos e imprimimos de manera unificada los datos de la memoria RAM
                print('--- GUARDANDO NUEVA CONSULTA ---');
                print('Cliente: ${clienteController.text}');
                print('Tema Legal: ${temaController.text}');
                print('Nro Expediente: ${expedienteController.text}');
                print('Estado Seleccionado: $estadoSeleccionado');
                print('---------------------------------');
              },
              
              // child: El componente visual interno del botón (el texto que indica su acción)
              child: const Text(
                'Guardar Consulta',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }
}