import 'package:app_gestion_abogados/src/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../models/consulta.dart';

class NuevaConsultaPage extends StatefulWidget {
  const NuevaConsultaPage({super.key});

  @override
  State<NuevaConsultaPage> createState() => _NuevaConsultaPageState();
}

class _NuevaConsultaPageState extends State<NuevaConsultaPage> {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController expedienteController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  final List<String> opcionesEstado = ['Pendiente', 'En análisis', 'Resuelto'];
  String estadoSeleccionado = 'Pendiente';

  @override
  void dispose() {
    clienteController.dispose();
    temaController.dispose();
    expedienteController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Consulta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Consultas');
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detalles del Caso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2B4B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingrese la información inicial para registrar una nueva consulta jurídica.',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: clienteController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A2B4B),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: 'NOMBRE DEL CLIENTE',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF1A2B4B),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: temaController.text.isEmpty
                      ? 'Civil'
                      : temaController.text,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF1A2B4B),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A2B4B),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: 'TIPO DE CONSULTA',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF1A2B4B),
                        width: 2.0,
                      ),
                    ),
                  ),
                  items: ['Civil', 'Penal', 'Laboral', 'Comercial'].map((
                    String tipo,
                  ) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (nuevoValor) {
                    setState(() {
                      temaController.text = nuevoValor!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: expedienteController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A2B4B),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: 'NRO. EXPEDIENTE',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF1A2B4B),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ESTADO INICIAL',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          estadoSeleccionado = 'Pendiente';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: estadoSeleccionado == 'Pendiente'
                              ? const Color(0xFFFFEAC1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: estadoSeleccionado == 'Pendiente'
                                ? const Color(0xFFFFC154)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Pendiente',
                              style: TextStyle(
                                color: const Color(0xFF1A2B4B),
                                fontWeight: estadoSeleccionado == 'Pendiente'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          estadoSeleccionado = 'En análisis';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: estadoSeleccionado == 'En análisis'
                              ? const Color(0xFFE0E7FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: estadoSeleccionado == 'En análisis'
                                ? const Color(0xFF818CF8)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'En Análisis',
                              style: TextStyle(
                                color: const Color(0xFF1A2B4B),
                                fontWeight: estadoSeleccionado == 'En análisis'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: descripcionController,
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1A2B4B),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              labelText: 'DESCRIPCIÓN DEL CASO',
              labelStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Color(0xFF1A2B4B),
                  width: 2.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.assignment_turned_in_outlined, size: 22),
              label: const Text(
                'GUARDAR CONSULTA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () async {
                final nuevaConsulta = Consulta(
                  idConsulta: DateTime.now().millisecondsSinceEpoch.toString(),
                  cliente: clienteController.text,
                  tema: temaController.text,
                  fecha: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  expediente: expedienteController.text,
                  estado: estadoSeleccionado,
                  descripcion: descripcionController.text,
                  contacto: '',
                );

                try {
                  await FirebaseService.guardarConsulta(nuevaConsulta);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Consulta guardada correctamente')),
                  );

                  Navigator.pop(context);
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
