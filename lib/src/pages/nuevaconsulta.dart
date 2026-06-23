import 'package:flutter/material.dart';
import '../models/consulta.dart'; // Tu modelo unificado para estructurar los datos

class NuevaConsultaPage extends StatefulWidget {
  const NuevaConsultaPage({super.key});

  @override
  State<NuevaConsultaPage> createState() => _NuevaConsultaPageState();
}

class _NuevaConsultaPageState extends State<NuevaConsultaPage> {
  // Controladores de la memoria RAM
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController expedienteController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  // Variables del Dropdown y selección de Estado
  final List<String> opcionesEstado = ['Pendiente', 'En análisis', 'Resuelto'];
  String estadoSeleccionado = 'Pendiente';

  @override
  void dispose() {
    // Liberación de memoria obligatoria para evitar fugas (Memory Leaks)
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
        // Colocamos manualmente la flecha de la imagen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Reemplaza '/Inicio' por el nombre de tu ruta principal
            Navigator.pushReplacementNamed(context, '/'); 
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Margen exterior
        children: [
          
          // TARJETA BLANCA CONTENEDORA (Detalles del Caso)
          Container(
            padding: const EdgeInsets.all(24.0), // Relleno interno
            decoration: BoxDecoration(
              color: Colors.white, // Fondo de la tarjeta
              borderRadius: BorderRadius.circular(24.0), // Esquinas redondeadas
              border: Border.all(color: Colors.grey.shade200), // Borde plano fino
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Todo alineado a la izquierda
              children: [
                
                // TÍTULO
                const Text(
                  'Detalles del Caso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2B4B), // Tu azul corporativo
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // SUBTÍTULO
                Text(
                  'Ingrese la información inicial para registrar una nueva consulta jurídica.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                
                const SizedBox(height: 24), // Espacio antes de los campos

                // 1. CAMPO CLIENTE
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF1A2B4B), width: 2.0),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Espaciador estético entre campos

                // 2. NUEVO CAMPO: TIPO DE CONSULTA (UBICADO DEBAJO DE CLIENTE)
                DropdownButtonFormField<String>(
                  initialValue: temaController.text.isEmpty ? 'Civil' : temaController.text,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1A2B4B)),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF1A2B4B), width: 2.0),
                    ),
                  ),
                  items: ['Civil', 'Penal', 'Laboral', 'Comercial'].map((String tipo) {
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

                const SizedBox(height: 20), // Espaciador estético antes de Expediente

                // 3. CAMPO EXPEDIENTE REDISEÑADO
                TextField(
                  controller: expedienteController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A2B4B), // Azul marino corporativo al escribir
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0), // Mismo radio de curvatura
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF1A2B4B), width: 2.0),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Espacio después de Expediente

                // ====================================================================
                // NUEVO COMPONENTE: SELECCIÓN DE ESTADO CON CHIPS DE COLOR
                // ====================================================================
                const Text(
                  'ESTADO INICIAL',
                  style: TextStyle(
                    color: Color(0xFF6B7280), // Gris elegante de la imagen
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12), // Espacio entre el título y los botones

                // Contenedor horizontal para ubicar los botones uno al lado del otro
                Row(
                  children: [
                    
                    // BOTÓN 1: PENDIENTE
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          estadoSeleccionado = 'Pendiente';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          // Si está seleccionado, se pinta de naranja pastel; si no, fondo blanco con borde gris
                          color: estadoSeleccionado == 'Pendiente' ? const Color(0xFFFFEAC1) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: estadoSeleccionado == 'Pendiente' ? const Color(0xFFFFC154) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // El puntito naranja característico de la imagen
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B), // Naranja sólido
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Pendiente',
                              style: TextStyle(
                                color: const Color(0xFF1A2B4B),
                                fontWeight: estadoSeleccionado == 'Pendiente' ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12), // Separación entre ambos botones

                    // BOTÓN 2: EN ANÁLISIS
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          estadoSeleccionado = 'En análisis';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          // Si está seleccionado se pinta de azul pastel suave; si no, fondo blanco
                          color: estadoSeleccionado == 'En análisis' ? const Color(0xFFE0E7FF) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: estadoSeleccionado == 'En análisis' ? const Color(0xFF818CF8) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // El puntito azul característico de la imagen
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3B82F6), // Azul sólido
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'En Análisis',
                              style: TextStyle(
                                color: const Color(0xFF1A2B4B),
                                fontWeight: estadoSeleccionado == 'En análisis' ? FontWeight.bold : FontWeight.normal,
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

                const SizedBox(height: 24), // Espacio amplio después de los botones de estado

                // 5. CAMPO: DESCRIPCIÓN DEL CASO (DENTRO DE LA TARJETA)
                TextField(
                  controller: descripcionController,
                  // minLines y maxLines controlan la expansión vertical del campo
                  minLines: 5, // Arranca con una altura fija equivalente a 5 líneas de texto
                  maxLines: 8, // Permite que se estire dinámicamente hasta 8 líneas si escribe mucho
                  keyboardType: TextInputType.multiline, // Modifica el botón 'Enter' del teclado para dar saltos de línea
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0), // Mismo radio uniforme de la app
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF1A2B4B), width: 2.0),
                    ),
                  ),
                ),
          
            const SizedBox(height: 24),
  
          // BOTÓN DE GUARDAR REDISEÑADO (TODO EL ANCHO + ICONO)
          // ====================================================================
          SizedBox(
            width: double.infinity, // Obliga al botón a ocupar el 100% del ancho disponible
            child: ElevatedButton.icon(
              // .icon es un constructor especial de ElevatedButton que acomoda el icono y el texto automáticamente
              icon: const Icon(Icons.assignment_turned_in_outlined, size: 22), 
              label: const Text(
                'GUARDAR CONSULTA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4B), // Tu azul marino corporativo
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18), // Le damos más altura para que sea cómodo de tocar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14), // Esquinas redondeadas modernas
                ),
                elevation: 0, // Quitamos la sombra exagerada para un look plano y moderno
              ),
              onPressed: () {
                // Tu lógica de negocio impecable que construimos antes
                final nuevaConsulta = Consulta(
                  idConsulta: DateTime.now().millisecondsSinceEpoch,
                  cliente: clienteController.text,
                  tema: temaController.text,
                  fecha: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  expediente: expedienteController.text,
                  estado: estadoSeleccionado,
                );

                print('--- OBJETO CONSULTA CREADO ---');
                print('Cliente: ${nuevaConsulta.cliente}');
                print('Estado: ${nuevaConsulta.estado}');
                print('Descripción: ${descripcionController.text}'); // Sumamos la descripción al print de control
                print('------------------------------');

                Navigator.pop(context); // Volver al listado automáticamente
              },
            ),
          ),
          
        ],
      ),
    );
  }
}